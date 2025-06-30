// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleStructMapping {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint depositCount;
        uint withdrawalCount;
        mapping(uint => Transaction) deposits;
        mapping(uint => Transaction) withdrawals;
    }

    mapping (address => Balance) public balances;

    function getMyBalance() public view returns (uint) {
        return balances[msg.sender].totalBalance;
    }

    function viewDeposit(address _address, uint _depositCount) public view returns (Transaction memory) {
        return balances[_address].deposits[_depositCount];
    }

    function depositMoney() public payable {
        balances[msg.sender].totalBalance += msg.value;
        
        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].depositCount] = deposit;
        balances[msg.sender].depositCount++;
    }
    
    function sendTo(uint _amount, address payable _to) public {
        balances[msg.sender].totalBalance -= _amount;
        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawals[balances[msg.sender].withdrawalCount] = withdrawal;
        balances[msg.sender].withdrawalCount++;
        _to.transfer(_amount);
    }
}