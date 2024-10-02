// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Character {
    struct CharacterData {
        uint256 balance;
        uint256 health;
        uint256 lastPaymentDate;
        uint256 lastPaymentAmount;
        string username;
    }

    address public owner;
    CharacterData public characterData;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    constructor(string memory username, address _owner) {
        owner = _owner;
        characterData.username = username;
        characterData.health = 100;
    }

    function deposit() external payable returns (uint256) {
        require(msg.value >= 0.01 ether, "error deposit");
        
        characterData.balance += msg.value;
        characterData.lastPaymentDate = block.timestamp;
        characterData.lastPaymentAmount = msg.value;

        return msg.value;
    }

    function increaseHealth(uint256 amount) external onlyOwner returns (uint256) {
        uint256 cost = amount * 0.001 ether;
        require(characterData.balance >= cost, "error health");

        characterData.balance -= cost;
        characterData.health += amount;

        return characterData.health;
    }

    function getCharacterData() external view returns (uint256, uint256, uint256, uint256, string memory) {
        return (
            characterData.balance,
            characterData.health,
            characterData.lastPaymentDate,
            characterData.lastPaymentAmount,
            characterData.username
        );
    }
}
