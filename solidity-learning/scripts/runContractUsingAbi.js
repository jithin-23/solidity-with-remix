(async() => {
    
    const address = "0x32f99155646d147b8A4846470b64a96dD9cBa414";
    const abi = [
	{
		"inputs": [],
		"name": "myUint",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newUint",
				"type": "uint256"
			}
		],
		"name": "setMyUint",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];
 
 
    let contractInstance = new web3.eth.Contract(abi, address);
 
    console.log(await contractInstance.methods.myUint().call());
    let accounts = await web3.eth.getAccounts();
    await contractInstance.methods.setMyUint(345).send({from: accounts[0]});
    
    console.log(await contractInstance.methods.myUint().call());
})()