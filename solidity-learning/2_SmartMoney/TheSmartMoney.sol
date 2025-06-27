// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SmartMoney {
    uint balanceRecieved;
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        balanceRecieved += msg.value; 
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    } 

    function withdrawAll() public {
        if(msg.sender == owner) {
            owner.transfer(getBalance());
            balanceRecieved=0;
        }
    }

    function sendTo(address payable _recipient) public {
        if(msg.sender == owner) {
            _recipient.transfer(getBalance());
            balanceRecieved=0;
        }
    }
}