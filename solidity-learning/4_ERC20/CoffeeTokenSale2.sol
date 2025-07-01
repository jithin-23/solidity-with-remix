//SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
 
interface IERC20 {
    function transfer(address to, uint amount) external;
    function decimals() external view returns(uint);
} 

contract TokenSale2 {
    uint tokenPriceInWei = 1 ether;
    IERC20 token;

    constructor (address _token) {
        token = IERC20(_token);
    }

    function purchase() public payable {
        require(msg.value>=tokenPriceInWei,"Not enough money sent");
        uint tokenToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value % tokenPriceInWei;

        token.transfer(msg.sender, tokenToTransfer);
        payable(msg.sender).transfer(remainder);
    }
}
