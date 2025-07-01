//SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
 
interface IERC20 {
    function transferFrom(address _from, address to, uint amount) external;
    function decimals() external view returns(uint);
} 

contract TokenSale {
    uint tokenPriceInWei = 1 ether;
    IERC20 token;
    address tokenOwner;

    constructor (address _token) {
        tokenOwner = msg.sender;
        token = IERC20(_token);
    }

    function purchase() public payable {
        require(msg.value>=tokenPriceInWei,"Not enough money sent");
        uint tokenToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value % tokenPriceInWei;

        token.transferFrom(tokenOwner, msg.sender, tokenToTransfer);
        payable(msg.sender).transfer(remainder);
    }
}
