//SPDX-License-Identifier: MIT
 
pragma solidity 0.8.16;
 
contract MyContract {
 
    uint public myUint = 123;
 
    function ComplexNameforSetMyUint(uint newUint) public {
        myUint = newUint;
    }
    
}