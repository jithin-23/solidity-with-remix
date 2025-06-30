// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ImprovedSmartMoney {
    mapping(address => uint) balanceRecieved;

    function deposit() public payable {
        balanceRecieved[msg.sender] += msg.value;
    }

    function getMyBalance() public view returns(uint) {
        return balanceRecieved[msg.sender];
    }

    function getAllBalance() public view returns (uint) {
        return address(this).balance;
    }

    function sendTo(address payable _to) public {
        uint moneyToSend = balanceRecieved[msg.sender];
        balanceRecieved[msg.sender] = 0;
        _to.transfer(moneyToSend);
    }
}