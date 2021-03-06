pragma solidity >=0.4.25 <0.6.0;

contract HomeTransaction {
    // Constants
    uint constant timeBetweenDepositAndFinalization = 14 days;
    uint constant depositPercentage = 1;
   
   
    enum ContractState {
        WaitingBuyerInterest,
        WaitingSellerSignature,
        WaitingBuyerSignature,
        WaitingAgentReview,
        WaitingFinalization,
        Finalized,
        Rejected }
    ContractState public contractState = ContractState.WaitingBuyerInterest;

    
    // Roles acting on contract
    address payable public Agent;
    address payable public seller;
    address payable public buyer;

    // Contract details
    string public homeAddress;
    string public zip;
    uint public AgentFee;
    uint public price;
    uint public proptype;
    string public district;
    uint public acco;
    uint public proparea;
    // Set when buyer signs and pays deposit
    uint public deposit;
    uint public finalizeDeadline;
    uint public lastOperationTime;
    // Set when Agent reviews closing conditions
    enum ClosingConditionsReview { Pending, Accepted, Rejected }
    ClosingConditionsReview closingConditionsReview = ClosingConditionsReview.Pending;

    constructor(
        
        string memory _address,
        string memory _zip,
        uint _AgentFee,
        uint _price,
        uint _proptype,
        uint _acco,
        uint _proparea,
        string memory _district,
        address payable _Agent,
        address payable _seller,
        address payable _buyer) public {
        require(_price >= _AgentFee, "Price needs to be more than Agent fee!");
        
        
        Agent = _Agent;
        proptype=_proptype;
        acco =_acco;
        proparea =_proparea;
        district=_district;
        seller = _seller;
        buyer = _buyer;
        homeAddress = _address;
        zip = _zip;
        price = _price;
        AgentFee = _AgentFee;
        
    }

       function buyerShowsInterest() public payable {
        

        require(contractState == ContractState.WaitingBuyerInterest, "Wrong contract state");

        contractState = ContractState.WaitingSellerSignature;
        buyer=tx.origin; //setting seller address
        lastOperationTime=now;
    }
    function sellerSignContract() public payable {
        require(seller == tx.origin, "Only seller can sign contract");

        require(contractState == ContractState.WaitingSellerSignature, "Wrong contract state");

        contractState = ContractState.WaitingBuyerSignature;
        buyer=tx.origin; //setting seller address
        lastOperationTime=now;
    }

    function buyerSignContractAndPayDeposit() public payable {
        require(buyer == tx.origin, "Only buyer can sign contract");

        require(contractState == ContractState.WaitingBuyerSignature, "Wrong contract state");
    
        require(msg.value >= price*depositPercentage/100 && msg.value <= price, "Buyer needs to deposit between 10% and 100% to sign contract");

        contractState = ContractState.WaitingAgentReview;

        deposit = msg.value;
        finalizeDeadline = now + timeBetweenDepositAndFinalization;
        lastOperationTime=now;
    }

    function AgentReviewedClosingConditions(bool accepted) public {
        require(Agent == tx.origin, "Only Agent can review closing conditions");

        require(contractState == ContractState.WaitingAgentReview, "Wrong contract state");
        
        if (accepted) {
            closingConditionsReview = ClosingConditionsReview.Accepted;
            contractState = ContractState.WaitingFinalization;
        } else {
            closingConditionsReview = ClosingConditionsReview.Pending;
            contractState = ContractState.WaitingBuyerInterest;
            
            buyer.transfer(deposit);
        }
        lastOperationTime=now;
    }

    function buyerFinalizeTransaction() public payable {
        require(buyer == tx.origin, "Only buyer can finalize transaction");

        require(contractState == ContractState.WaitingFinalization, "Wrong contract state");

        require(msg.value + deposit == price, "Buyer needs to pay the rest of the cost to finalize transaction");

        contractState = ContractState.Finalized;

        seller.transfer(price-AgentFee);
        Agent.transfer(AgentFee);
        lastOperationTime=now;
    }

    function anyWithdrawFromTransaction() public payable{
        require(buyer == tx.origin || finalizeDeadline <= now, "Only buyer can withdraw before transaction deadline");

        require(contractState == ContractState.WaitingFinalization, "Wrong contract state");

       contractState = ContractState.Rejected;

        seller.transfer(deposit-AgentFee);
        Agent.transfer(AgentFee);
        lastOperationTime=now;
    }
    
}
