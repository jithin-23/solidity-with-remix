// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ContractOne {
    receive() external payable {}

    function depositToContractTwo(address _to) public {
        (bool isSuccess, ) = _to.call{value:10, gas:100000}("");
        require(isSuccess, "Failed to send Ether");
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract ContractTwo {
    mapping (address => uint) receivedBalances;
    receive() external payable {
        receivedBalances[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}