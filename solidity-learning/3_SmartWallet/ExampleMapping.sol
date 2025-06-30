// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SampleMapping {
    mapping (uint => bool) public myMapping;
    mapping (address => bool) public myAddressMapping;

    function setMyMapping(uint _index) public {
        myMapping[_index] = true;
    }

    function setAddressMapping() public {
        myAddressMapping[msg.sender] = true;
    }

    mapping (uint => mapping (uint => bool)) public myMatrix;
    function setMyMatrix(uint _index1, uint _index2) public {
        myMatrix[_index1][_index2] = true;
    }
}