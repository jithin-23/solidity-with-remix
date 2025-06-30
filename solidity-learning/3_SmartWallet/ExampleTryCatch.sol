//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;
 
contract WillThrow {
    error ThisIsACustomError(string);
    function aFunction() public pure {
        require(false, "Error message");
        // assert(false);
        // revert ThisIsACustomError("You have thrown a custom error");
    }
}
 
contract ErrorHandling {
    event ErrorLogging(string reason);
    event ErrorLogCode(uint errorCode);
    event ErrorLogBytes(bytes lowLevelData);
    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            //here we could do something if it works
        }  catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }  catch Panic (uint errorCode) {
            emit ErrorLogCode(errorCode);
        }  catch (bytes memory lowLevelData) {
            emit ErrorLogBytes(lowLevelData);
        }

    }
}