// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract BlockchainMessenger {
    uint public messageCounter;
    string public myMessage;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setMyMessage(string memory _newMessage) public {
        if(msg.sender == owner) {
            myMessage = _newMessage;
            messageCounter++;
        }
    }

}