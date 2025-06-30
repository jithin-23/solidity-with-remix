// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleRequireAssert {
    mapping(address => uint8) balanceReceived;

    function getMyBalance() public view returns (uint8) {
        return balanceReceived[msg.sender];
    }

    function desositMoney() public payable {
        assert(msg.value==uint8(msg.value));
        balanceReceived[msg.sender] += uint8(msg.value);
    }

    function withdrawMoney(uint8 _amount, address payable _to) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}