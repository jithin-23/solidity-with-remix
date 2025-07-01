//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import {Owned} from "./Ownable.sol";

contract Token is Owned {
    mapping(address => uint) public tokenBalance;
    uint tokenPrice = 1 ether;

    constructor () {
        tokenBalance[owner] += 100;
    }


    function mintToken() public onlyOwner {
        tokenBalance[msg.sender]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[msg.sender]--;
    }

    function buyToken() public payable {
        uint newTokens = msg.value/tokenPrice;
        tokenBalance[msg.sender] += newTokens;
    }

    function sendTokens(address _to, uint _amount) public {
        require(tokenBalance[msg.sender]>=_amount,"You don't have enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

}