import contractAbi from './abi.js'

const contractAddress = '0x9389C7FCEF350788b979b58Bf129938D3a2Afeb1'


const loadWeb3 = async () => {
  if (window.ethereum) {
    window.web3 = new Web3(window.ethereum)
    window.ethereum.enable
  }
}

const loadContract = async () => await new window.web3.eth.Contract(contractAbi, contractAddress) 

const load = async () => {
  await loadWeb3();
  window.contract = await loadContract();
  updateStatus('Ready!');
}

const updateStatus = status => {
  const statusEl = document.getElementById('status');
  statusEl.innerHTML = status;
  console.log(status);
}

load();

