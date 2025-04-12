const { ethers } = require("ethers");
const abi = require("./Gen3vo_abi.json");
const provider = new ethers.providers.JsonRpcProvider("https://sepolia.infura.io/v3/YOUR_API_KEY");
const wallet = new ethers.Wallet("0xYourPrivateKeyHere", provider);
const contract = new ethers.Contract("0xYourDeployedAddressHere", abi, wallet);
(async () => {
    const tx = await contract.submitTask("Map dormant public funds in Middleton");
    await tx.wait();
    console.log("✅ Task submitted:", tx.hash);
})();
