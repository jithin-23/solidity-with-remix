// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SampleFallback {
    // Track the last ETH value sent to the contract
    uint public lastValueSent;

    // Store which special function was called (receive or fallback)
    string public lastFunctionCalled;

    // A regular state variable that can be set via function
    uint public myNumber;

    // ✅ Normal function to set myNumber
    function setMyNumber(uint _newNum) public {
        myNumber = _newNum;
    }

    // ✅ Special function triggered when:
    // - ETH is sent directly to the contract
    // - And msg.data is empty (i.e., no function called)
    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    // ✅ Special function triggered when:
    // - msg.data is not empty (e.g., unknown function called)
    // - Or if receive() doesn't exist and ETH is sent
    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }

    function getAccountBalance() view public returns(uint) {
        return address(this).balance;
    }
}
