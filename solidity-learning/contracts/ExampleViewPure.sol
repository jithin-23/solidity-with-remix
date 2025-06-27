// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleViewPure {
    // A state variable stored permanently on the blockchain
    uint public myStorageVariable;

    // ❌ Regular "write" function (no view or pure)
    // ✅ Modifies the blockchain state (updates myStorageVariable)
    // ❌ Costs gas when called
    // ⚠️ Note: We are returning a value here, but this return value
    // is only useful for **internal calls (contract-to-contract)**.
    // When calling from frontend (like web3.js or ethers.js), the return
    // value is not available unless you simulate the call (which avoids writing).
    // ➤ In practice, write functions usually don't return anything.
    function setMyStorageVariable(uint _myStorageVariable) public returns(uint) {
        myStorageVariable = _myStorageVariable; // This changes state
        return _myStorageVariable; // Return useful only for other contracts
    }

    // ✅ "view" function
    // ✅ Can read blockchain state
    // ❌ Cannot modify it
    // ✅ Free to call from frontend (no gas if called as a call, not a transaction)
    function getMyStorageVariable() public view returns (uint) {
        return myStorageVariable; // Only reading state
    }

    // ✅ "pure" function
    // ❌ Cannot read or modify state
    // ✅ Only uses inputs and internal computation
    // ✅ Free to call from frontend
    function getAddition(uint a, uint b) public pure returns(uint) {
        return a + b; // Pure logic, no state interaction
    }
}
