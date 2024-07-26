// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Bank {
    address public immutable owner;

    event Deposit(address _ads,uint256 amount);
    event Withdraw(uint256 amount);
    

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
       emit Deposit(msg.sender,msg.value);
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        emit Withdraw(amount);
        //selfdestruct(payable(msg.sender));
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
