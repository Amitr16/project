pragma solidity ^0.5.11;
contract PropertyContract
{
 
 enum PropStatusType
    {
    Pending, //0
    Sold //1
    }
 struct Property
 {
 address  ownerAddress;
 string location;
 uint cost;
 uint PropID;
 PropStatusType PropStatus;
 }
 uint public totalPropCounter; //total no oÿ lands via this contract at any time
 constructor () public
 {
 totalPropCounter = 0;
 }

//land addition event
 event Add(address _owner, uint _PropID);
 event Onwershipchanged(address ownerAddress, bool isMember);
 //one account can hold many lands (many landTokens, each token one land)
 mapping (address => Property[]) public __ownedProperty;
 mapping(uint=> address) getAddressFromPropID;


 function addProperty(address propertyOwner,string memory _location, uint _cost) public returns (uint)
 {
 totalPropCounter = totalPropCounter + 1;
 
 Property memory myProp = Property(
 {
 ownerAddress: propertyOwner,
 location: _location,
 cost: _cost,
 PropID: totalPropCounter,
 PropStatus: PropStatusType.Pending });
  __ownedProperty[propertyOwner].push(myProp);
 emit Add(propertyOwner, totalPropCounter);
 getAddressFromPropID[totalPropCounter]=propertyOwner;
 return totalPropCounter;
 }
 //GET TOTAL NO OF LANDS OWNED BY AN ACCOUNT
 function getNoOfProperties(address _PropHolder) view public returns (uint)
 {
 uint index;
 index = __ownedProperty[_PropHolder].length;
 return index;
 }
 //get total lands counter
 function getTotalPropertyCounter() public view returns (uint)
 {
 return totalPropCounter;
 }
  function getUnsoldPropertyIDs(address _PropHolder) public view returns (uint[] memory)
 {
   uint[] memory arrPropID = new uint[](__ownedProperty[_PropHolder].length);
   for(uint i=0; i < (__ownedProperty[_PropHolder].length);i++)
 {
    
    if (__ownedProperty[_PropHolder][i].PropStatus==PropStatusType.Pending ){
    arrPropID[i]=__ownedProperty[_PropHolder][i].PropID;}
 
 }
 return arrPropID;
 }
 
   function getPropertyDetails(address _PropHolder, uint _PropID) public  returns (PropStatusType , uint, string memory)
 {
    
   
   for(uint i=0; i < (__ownedProperty[_PropHolder].length);i++)
 {
    
    if (__ownedProperty[_PropHolder][i].PropID==_PropID ){
 
         return (__ownedProperty[_PropHolder][i].PropStatus, __ownedProperty[_PropHolder][i].cost, __ownedProperty[_PropHolder][i].location);
        }
   
 
 }

 }
 
 function EditPropertyValue(uint _PropID,uint _newVal) public returns (uint)
 {
        
        for(uint i=0; i < __ownedProperty[getAddressFromPropID[_PropID]].length;i++){
            if ( __ownedProperty[getAddressFromPropID[_PropID]][i].PropID==_PropID ){
                __ownedProperty[getAddressFromPropID[_PropID]][i].cost=_newVal;
                 return __ownedProperty[getAddressFromPropID[_PropID]][i].cost;
        
     }}}
 
  function BuyProperty(uint _PropID,address _NewPropHolder) public returns (bool)
 {
    
    
    
      for(uint i=0; i < __ownedProperty[getAddressFromPropID[_PropID]].length;i++){
            if ( __ownedProperty[getAddressFromPropID[_PropID]][i].PropID==_PropID ){
                if(_NewPropHolder!=__ownedProperty[getAddressFromPropID[_PropID]][i].ownerAddress && __ownedProperty[getAddressFromPropID[_PropID]][i].PropStatus== PropStatusType.Pending){
                    __ownedProperty[getAddressFromPropID[_PropID]][i].ownerAddress=_NewPropHolder ;
                    __ownedProperty[getAddressFromPropID[_PropID]][i].PropStatus= PropStatusType.Sold;
     
}}}}
 
}