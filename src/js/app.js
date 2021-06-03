var   account=0;
var contract =0;
const getWeb3 = () => {
  return new Promise((resolve, reject) => {
    window.addEventListener("load", async () => {
      if (window.ethereum) {
        const web3 = new Web3(window.ethereum);
        try {
          // ask user permission to access his accounts
          await window.ethereum.request({ method: "eth_requestAccounts" });
          resolve(web3);
        } catch (error) {
          reject(error);
        }
      } else {
        reject("must install MetaMask");
      }
    });
  });
};

const getContract = async (web3) => {
  const data = await $.getJSON("Factory.json");
  
  Factory = TruffleContract(data);
  Factory.setProvider(window.ethereum);
  LandContract = await Factory.deployed()

  return LandContract;
   
};

const GetPropCount = async () => {
  const result = await contract.getInstanceCount({ from: account })
    return result ;  
};

const getPropPrice = async (Index) => {
  const result = await contract.getInstancePrice(Index,{ from: account })
    return result ;  
};

const getPropAddress= async (Index) => {
  const result = await contract.getInstanceAddress(Index,{ from: account })
    return result ;  
};

const getPropZIP = async (Index) => {
  const result = await contract.getInstanceZIP(Index,{ from: account })
    return result ;  
};
 
 const getPropCity= async (Index) => {
  const result = await contract.getInstanceCity(Index,{ from: account })
    return result ;  
};

const getLastOpsTime= async (Index) => {
  const result = await contract.getLastOpsTime(Index,{ from: account })
    return result ;  
};

const getPropAgentFee=async (Index) => {
  const result = await contract.getInstanceAgentFee(Index,{ from: account })
    return result ;  
};

const getInstanceProptype =async (Index) => {
  const result = await contract.getInstanceProptype(Index,{ from: account })
    return result ;  
};

const getInstanceDistrict=async (Index) => {
  const result = await contract.getInstanceDistrict(Index,{ from: account })
    return result ;  
};

const getPropSellerAddress =async(Index) => {
  const result = await contract.getInstanceSellerAddress(Index,{ from: account })
    return result ;  
};

const getPropBuyerAddress=async(Index) => {
  const result = await contract.getInstanceBuyerAddress(Index,{ from: account })
    return result ;  
};

const getPropAgentAddress=async(Index) => {
  const result = await contract.getInstanceAgentAddress(Index,{ from: account })
    return result ;  
};

const getPropFromState=async(state) => {
  const result = await contract.getPropFromState(state,{ from: account })
    return result ;  
};

const getPropFromInvState=async(state) => {
  const result = await contract.getPropFromInvState(state,{ from: account })
  
    return result ;  
};

const getPropFromDistrict=async() => {
  const result = await contract.getPropFromDistrict({ from: account })
    return result ;  
};
const getInstanceAcco=async(index) => {
  const result = await contract.getInstanceAcco(index,{ from: account })
    return result ;  
};
const getInstancePropArea=async(index) => {
  const result = await contract.getInstancePropArea(index,{ from: account })
    return result ;  
};


const getPropFromPropType=async() => {
  const result = await contract.getPropFromPropType({ from: account })
    return result ;  
};

const getPropFromBuyer=async() => {
  const result = await contract.getPropFromBuyer({ from: account })
    return result ;  
};

const getPropFromSeller=async() => {
  const result = await contract.getPropFromBuyer({ from: account })
    return result ;  
};
const getPropFromLawyer=async() => {
  const result = await contract.getPropFromBuyer({ from: account })
    return result ;  
};

const getPropState=async(Index) => {
  const result = await contract.getInstanceState(Index,{ from: account })
    return result ;  
};
const ShowInterest=async(index) => {
 
 
  await contract.buyerShowsInterest(index,{ from: account });
  
     
};

const addProperty = async () => {

  var location= $('#location').val();

    var pin= $('#pin').val();
     var Fee1= $('#Fee1').val();
    var Fee2= $('#Fee2').val();
    var add1= document.getElementById("Lawname").value;
    var proptype=document.getElementById("proptype").value;
    var acco=document.getElementById("acco").value;
    var distr= document.getElementById("distr").value;
    var proparea=$('#area').val();
    contract.create(location,pin,Fee1,Fee2,proptype,acco,proparea,distr,add1,{ from:account });
};


async function PropertyApp() {
  
  const web3 =  await getWeb3();
  
  web3.eth.getAccounts(function(err,result){
    if(!err){
    account = result[0];
        // console.log(App.account );
    }
  });
  contract = await getContract(web3);
  
  prop = await GetPropCount();
  // document.getElementById("PropCount").innerHTML="Total no. of Properties is :"+prop.c;
  ShowHDBPropDetails();
  ShowCondoPropDetails();
  ShowLandedPropDetails();
  
}



PropertyApp();

async function ShowTableUI(){
  var index= $('#propid').val();
  // index =6;
  // alert(index);
  selladdout = await getPropSellerAddress(index);
  buyeraddout = await getPropBuyerAddress(index);
  lawaddout = await getPropAgentAddress(index);
  locout = await getPropAddress(index);
  Statusout = await getPropState(index);
  document.getElementById("ID").innerHTML=index;
  document.getElementById("selladdout").innerHTML=selladdout;
  document.getElementById("buyeraddout").innerHTML=buyeraddout;
  document.getElementById("lawaddout").innerHTML=lawaddout;
  document.getElementById("locout").innerHTML=locout;
  document.getElementById("Statusout").innerHTML=Statusout;



}


async function ShowHDBPropDetails(){
  let accotype=["Studio","1B1T","2B1T","3B2T","4B3T"];
  strDet=document.getElementById("HDBDet").innerHTML;
  strDet1=document.getElementById("HDBDet1").innerHTML;
  document.getElementById("HDBDet").innerHTML="";
  document.getElementById("HDBDet1").innerHTML="";
  c=-1;
for (i=0; i<await GetPropCount() ;i++){
  state = await getPropState(i);
  
  PropType =await getInstanceProptype(i);
  if(state!=0 || PropType!=0)
   continue;

  locout = await getPropAddress(i);
  c++;
  
  lastupdate=await getLastOpsTime(i);
  
  lastdate= new Date(lastupdate*1000);
  PropDistr= await getInstanceDistrict(i);
  Statusout = await getPropState(i);
  price =await getPropPrice(i);
  area = await getInstancePropArea(i);
  acco = await getInstanceAcco(i);
  psf = price/area;
  if (c%2==0){
    document.getElementById("HDBDet").innerHTML+=strDet.replace("xxx",locout).replace("yyy",PropDistr).replace("zzz",price).replace("aaa",accotype[acco-1]).replace("bbb",area).replace("ccc",psf).replace("ddd",i);
  }  
  else{
    document.getElementById("HDBDet1").innerHTML+=strDet1.replace("xxx",locout).replace("yyy",PropDistr).replace("zzz",price).replace("aaa",accotype[acco-1]).replace("bbb",area).replace("ccc",psf).replace("ddd",i);
  }
  
}}

async function ShowCondoPropDetails(){
 
  let accotype=["Studio","1B1T","2B1T","3B2T","4B3T"];
  strDet=document.getElementById("CondoDet").innerHTML;
  strDet1=document.getElementById("CondoDet1").innerHTML;
  document.getElementById("CondoDet").innerHTML="";
  document.getElementById("CondoDet1").innerHTML="";
  c=-1;
for (i=0; i<await GetPropCount() ;i++){
  state = await getPropState(i);
  
  PropType =await getInstanceProptype(i);
  if(state!=0 || PropType!=1)
   continue;
  locout = await getPropAddress(i);
  c++;
  lastupdate=await getLastOpsTime(i);
  
  lastdate= new Date(lastupdate*1000);
  PropDistr= await getInstanceDistrict(i);
  Statusout = await getPropState(i);
  price =await getPropPrice(i);
  area = await getInstancePropArea(i);
  acco = await getInstanceAcco(i);
  psf = price/area;
  if (c%2==0){
    document.getElementById("CondoDet").innerHTML+=strDet.replace("xxx",locout).replace("yyy",PropDistr).replace("zzz",price).replace("aaa",accotype[acco-1]).replace("bbb",area).replace("ccc",psf).replace("ddd",i);
  }  
  else{
    document.getElementById("CondoDet1").innerHTML+=strDet1.replace("xxx",locout).replace("yyy",PropDistr).replace("zzz",price).replace("aaa",accotype[acco-1]).replace("bbb",area).replace("ccc",psf).replace("ddd",i);
  }
  
}}
async function ShowLandedPropDetails(){
  let accotype=["Studio","1B1T","2B1T","3B2T","4B3T"];
  strDet=document.getElementById("LandedDet").innerHTML;
  strDet1=document.getElementById("LandedDet1").innerHTML;
  document.getElementById("LandedDet").innerHTML="";
  document.getElementById("LandedDet1").innerHTML="";
  c=-1;
for (i=0; i<await GetPropCount() ;i++){
  state = await getPropState(i);
  
  PropType =await getInstanceProptype(i);
  if(state!=0 || PropType!=2)
   continue;
  locout = await getPropAddress(i);
  c++;
  lastupdate=await getLastOpsTime(i);
  
  lastdate= new Date(lastupdate*1000);
  PropDistr= await getInstanceDistrict(i);
  Statusout = await getPropState(i);
  price =await getPropPrice(i);
  area = await getInstancePropArea(i);
  acco = await getInstanceAcco(i);
  psf = price/area;
  if (c%2==0){
    document.getElementById("LandedDet").innerHTML+=strDet.replace("xxx",locout).replace("yyy",PropDistr).replace("zzz",price).replace("aaa",accotype[acco-1]).replace("bbb",area).replace("ccc",psf).replace("ddd",i);
  }  
  else{
    document.getElementById("LandedDet1").innerHTML+=strDet1.replace("xxx",locout).replace("yyy",PropDistr).replace("zzz",price).replace("aaa",accotype[acco-1]).replace("bbb",area).replace("ccc",psf).replace("ddd",i);
  }
  
}}