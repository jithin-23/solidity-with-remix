(async () => {
    if (typeof window.ethereum !== 'undefined') {
        ethereum.request({ method: 'eth_requestAccounts' });
    }
    
})()