pragma solidity >=0.4.25 <0.6.0;

import "./HomeTransaction.sol";

contract Factory {
  HomeTransaction[] contracts;
  
        
  function create(
        string memory _address,
        string memory _zip,
        uint _realtorFee,
        uint _price,
        uint _proptype,
        uint _acco,
        uint _proparea,
        string memory _district,
        address payable _Agent) public returns(HomeTransaction homeTransaction)  {
    homeTransaction = new HomeTransaction(
      _address,
      _zip,
      _realtorFee,
      _price,
      _proptype,
      _acco,
      _proparea,
      _district,
      _Agent,
     msg.sender,
      msg.sender);
    contracts.push(homeTransaction);

    
  }

  function getInstance(uint index) public view returns (HomeTransaction instance) {
    require(index < contracts.length, "index out of range");

    instance = contracts[index];
  }
  function getLastOpsTime(uint index) public view returns (uint ) {
    require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return uint(instance.lastOperationTime());
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
   function getInstanceProptype(uint index) public view returns (uint) {
  require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.proptype();
  }
     function getInstanceAcco(uint index) public view returns (uint) {
  require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.acco();
  }
    function getInstancePropArea(uint index) public view returns (uint) {
  require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.proparea();
  }
   function getInstanceDistrict(uint index) public view returns (string memory) {
  require(index < contracts.length, "index out of range");

    HomeTransaction instance = contracts[index];
    return instance.district();
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
  
  function getPropFromState(uint state) public view returns (uint[] memory ) {
    uint n =contracts.length;
    uint[] memory ArrID =new uint[](n);
    for(uint i=0; i < n;i++){
        if(getInstanceState(i)==state){
            ArrID[i]=i+1;}
    }
    return ArrID;
    
  }
  
   function getPropFromPropType(uint proptype) public view returns (uint[] memory ) {
    uint n =contracts.length;
    uint[] memory ArrID =new uint[](n);
    for(uint i=0; i < n;i++){
        if(getInstanceState(i)==proptype){
            ArrID[i]=i+1;}
    }
    return ArrID;
    
  }
  

  
  function getPropFromInvState(uint state) public view returns (uint[] memory ) {
  uint n =contracts.length;
    uint[] memory ArrID =new uint[](n);
    for(uint i=0; i < n;i++){
        if(getInstanceState(i)!=state){
            ArrID[i]=i+1;}
    }
    return ArrID;
  }


  function getPropFromBuyer(address indexadd) public view returns (uint[] memory ) {
  uint n =contracts.length;
    uint[] memory ArrID =new uint[](n);
    for(uint i=0; i < n;i++){
        if(getInstanceBuyerAddress(i)==indexadd){
            ArrID[i]=i+1;}
    }
    return ArrID;
  }
  
  
  function getPropFromSeller(address indexadd) public view returns (uint[] memory ) {
  uint n =contracts.length;
    uint[] memory ArrID =new uint[](n);
    for(uint i=0; i < n;i++){
        if(getInstanceSellerAddress(i)==indexadd){
            ArrID[i]=i+1;}
    }
    return ArrID;
  }
  
  function getPropFromLawyer(address indexadd) public view returns (uint[] memory ) {
  uint n =contracts.length;
    uint[] memory ArrID =new uint[](n);
    for(uint i=0; i < n;i++){
        if(getInstanceAgentAddress(i)!=indexadd){
            ArrID[i]=i+1;}
    }
    return ArrID;
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