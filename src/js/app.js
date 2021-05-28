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

const getPropAgentFee=async (Index) => {
  const result = await contract.getInstanceAgentFee(Index,{ from: account })
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

const getPropState=async(Index) => {
  const result = await contract.getInstanceState(Index,{ from: account })
    return result ;  
};
const ShowInterest=async() => {
  alert(0);
  await contract.buyerShowsInterest(1,{ from: account })
  alert(1);
     
};

const addProperty = async () => {
  var location= $('#location').val();
    var pin= $('#pin').val();
    var city= $('#city').val();
    var Fee1= $('#Fee1').val();
    var Fee2= $('#Fee2').val();
    var add1= $('#add1').val();
    contract.create(location,pin,city,Fee1,Fee2,add1,{ from:account });
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
  document.getElementById("PropCount").innerHTML="Total no. of Properties is :"+prop.c;
  ShowTableUI();
  
}



PropertyApp();

async function ShowTableUI(){
  var index= $('#propid').val();
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