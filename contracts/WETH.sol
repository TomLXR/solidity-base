// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract WETH {
    string public name = "Wrapped Ether";
    event Approval(address indexed src, address indexed dst, uint256 amount);
    event Transfer(address indexed src, address indexed dst, uint256 amount);
    event Deposit(address indexed dst, uint256 amount);
    event Withdrawal(address indexed src, uint256 amount);
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    function approve(address spender, uint256 amount) public  returns (bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address dst,uint256 amount) public returns (bool){
       return transferFrom(msg.sender, dst, amount);
    }

    function transferFrom(address src,address dst,uint256 amount)   public returns (bool){
        require(balanceOf[src] >= amount);
        if(src != msg.sender){
            require(allowance[src][msg.sender] >= amount);
            allowance[src][msg.sender] -= amount;
        }
        balanceOf[src] -= amount;
        balanceOf[dst] += amount;
        emit Transfer(src, dst, amount);
        return true;
    }

    fallback() external payable {
        deposit();
    }

    receive() external payable {
        deposit();
    }
}
