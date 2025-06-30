// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleArrays {
    // Dynamic array stored in contract storage
    uint[] public myArray;

    // ✅ Adds a value to the end of the array
    function addToArray(uint _value) public {
        myArray.push(_value);
    }

    // ⚠️ Edits an element at a specific index
    // ❗ Will revert if the index is out of bounds
    // That's because arrays in Solidity must be explicitly populated first
    // Example: Trying to set myArray[5] without pushing at least 6 elements will fail
    function editArray(uint _index, uint _value) public {
        myArray[_index] = _value; // Reverts if _index >= myArray.length
    }

    // ✅ Returns all array values
    function getAllValues() public view returns (uint[] memory) {
        return myArray;
    }
}
