//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleUint {
    uint256 public myUint=2; // 0 to (2^256)-1
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    uint8 public myUint8 = 250;
    function incrementUint8() public {
        myUint8++;
    }

    int public myInt=2; // -2^128 to 2^128
    function decrementInt() public {
        myInt--;
    }

    function decrementmyUint() public {
        myUint--;
    }

    function uncheckedDecrementmyUint() public { 
        unchecked{ //So old version of the compiler like 0.7, it was unchecked by default. newer version has inbuilt checks to prevent wraparounds
            myUint--;
        }
    }
}