//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SampleContract{
    uint public myNumber=10;
    function  setMyNumber(uint _newNumber) payable public {
        if(msg.value == 1 ether ) {
            myNumber = _newNumber;
        }
        else {
            payable(msg.sender).transfer(msg.value);
        }
    }
}