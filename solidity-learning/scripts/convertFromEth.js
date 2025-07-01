(async () => {
    const ether = "1";

    const wei = web3.utils.toWei(ether, "ether");
    const gwei = web3.utils.toWei(ether, "gwei");
    const finney = web3.utils.toWei(ether, "finney");

    console.log("Ether   :", ether);     // 1 ether = 1e18 wei
    console.log("Gwei  :", gwei);    // 1 ether = 1e9 gwei
    console.log("Finney:", finney);  // 1 ether = 1e3 finney
    console.log("Wei   :", wei);     // 1 ether = 1e18 wei
})();
