//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract Owned {
    address owner;
    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender==owner,"You are not the owner. Not allowed!");
        _;
    }
}