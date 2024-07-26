// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Demo {
  struct Todo{
    string name;
    bool completed;
  }

  Todo[] public todos;
  function create(string memory name_) external {
      todos.push(Todo({
        name: name_,
        completed: false
      }));
  
  }


  function modiName1(uint256 index_,string memory name_) external {
    todos[index_].name = name_;
  }

  function modiName2(uint256 index_,string memory name_) external {
      Todo storage  temp=todos[index_];
      temp.name = name_;
  
  }

  function modiStatus1(uint256 index_,bool status_) external {
      todos[index_].completed = status_;
  }

   function modiStatus2(uint256 index_) external {
      todos[index_].completed = !todos[index_].completed ;
  }


   function get1(uint256 index_) external view returns (string memory name_,bool status_){
      Todo memory temp=todos[index_];
      return (temp.name,temp.completed);

   }

   function get2(uint256 index_) external view returns (string memory name_,bool status_){
      Todo storage temp=todos[index_];
      return (temp.name,temp.completed);

   }
}
