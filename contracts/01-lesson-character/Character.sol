// SPDX-License-Identifier: MIT 
  
pragma solidity ^0.8.0;

contract Character{
    string public username;

    struct CharacterData {
        uint256 balance;
        uint256 health;
        uint256 lastPaymentDate;
        uint256 lastPaymentAmount;
    }

    CharacterData public characterdata;
    address public owner;

    constructor(string memory _username){
        username =_username;
        owner = msg.sender;
        characterdata.health = 100; 
        require(owner != address(0), "Error");
    }

    modifier onlyOwner(){
        require(msg.sender==owner, "Not the owner");
        _;
    }

    function deposite() payable external returns(uint256){
        require(msg.value >= 0.01 ether, "0.01 ETH minimum");
        characterdata.balance += msg.value;
        characterdata.lastPaymentDate = block.timestamp;
        characterdata.lastPaymentAmount = msg.value;
        return msg.value;
    }

    function increaseHealth(uint256 amount) payable external onlyOwner returns(uint256){
        uint256 cost = amount * 0.001 ether;
        require(characterdata.balance >= cost, "Error");
        characterdata.health += amount;
        characterdata.balance -= cost;
        return characterdata.health;
    }
}