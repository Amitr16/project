pragma solidity >=0.4.25 <0.6.0;

import "./HomeTransaction.sol";

contract Factory {
  HomeTransaction[] contracts;
  
        
  function create(
        string memory _address,
        string memory _zip,
        string memory _city,
        uint _realtorFee,
        uint _price,
        address payable _Agent) public returns(HomeTransaction homeTransaction)  {
    homeTransaction = new HomeTransaction(
      _address,
      _zip,
      _city,
      _realtorFee,
      _price,
      _Agent,
     msg.sender,
      msg.sender);
    contracts.push(homeTransaction);
  }

  function getInstance(uint index) public view returns (HomeTransaction instance) {
    require(index < contracts.length, "index out of range");

    instance = contracts[index];
  }

  function getInstances() public view returns (HomeTransaction[] memory instances) {
    instances = contracts;
  }

  function getInstanceCount() public view returns (uint count) {
    count = contracts.length;
  }
  function getInstancePrice(uint index) public view returns (uint) {
   require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.price();
  }
 function getInstanceAddress(uint index) public view returns (string memory) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.homeAddress();
  }
  function getInstanceZIP(uint index) public view returns (string memory) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.zip();
  }
  function getInstanceCity(uint index) public view returns (string memory) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.city();
  }
  function getInstanceAgentFee(uint index) public view returns (uint) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.AgentFee();
  }
  function getInstanceSellerAddress(uint index) public view returns (address ) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.seller();
  }
  function getInstanceBuyerAddress(uint index) public view returns (address ) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.buyer();
  }
  function getInstanceAgentAddress(uint index) public view returns (address ) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.Agent();
  }
  function getInstanceState(uint index) public view returns (uint ) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return uint(instance.contractState());
  }
  function buyerShowsInterest(uint index) public payable
{
    require(index < contracts.length, "index out of range");
    HomeTransaction instance = contracts[index];
   instance.buyerShowsInterest();
}
function sellerSignContract(uint index) public payable
{
    require(index < contracts.length, "index out of range");
    HomeTransaction instance = contracts[index];
   instance.sellerSignContract();
}
function buyerSignContractAndPayDeposit(uint index) public payable
{
    require(index < contracts.length, "index out of range");
    HomeTransaction instance = contracts[index];
   instance.buyerSignContractAndPayDeposit();
}
function AgentReviewedClosingConditions(uint index,bool accept) public payable
{
    require(index < contracts.length, "index out of range");
    HomeTransaction instance = contracts[index];
   instance.AgentReviewedClosingConditions(accept);
}
function buyerFinalizeTransaction(uint index) public payable
{
    require(index < contracts.length, "index out of range");
    HomeTransaction instance = contracts[index];
   instance.buyerFinalizeTransaction();
}
function anyWithdrawFromTransaction(uint index) public payable
{
    require(index < contracts.length, "index out of range");
    HomeTransaction instance = contracts[index];
   instance.anyWithdrawFromTransaction();
}
  
}