// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Character {
    string username;
    address owner;
    uint health;

    constructor(string memory nameIn, address _owner) payable {
        owner = payable(_owner);
        username = nameIn;
        characterData.username = nameIn;
        characterData.health = 100;
        // lastPaymentDate = block.timestamp;
        // lastPaymentAmount = (msg.value);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    struct CharacterData {
        uint balance;
        uint health;
        string username;
        uint lastPaymentAmount;
        uint lastPaymentDate;
    }

    CharacterData characterData;

    function deposit() public payable returns (uint) {
        require(msg.value > 0.01 ether, "error deposit");
        characterData.balance += msg.value;
        characterData.lastPaymentAmount = msg.value;
        characterData.lastPaymentDate = block.timestamp;
        return msg.value;
    }

    address to = 0x0000000000000000000000000000000000000000;

    function increaseHealth(uint heal) public payable onlyOwner returns (uint256) {
        require(characterData.balance >= 0.001 ether, "error health");
        characterData.balance -= 0.001 ether;
        (bool sent, ) = to.call{value: 0.001 ether}("");
        require(sent, "ETH burn failed");
        characterData.health += heal;
        return characterData.health;
    }

    function getCharacterData() public view returns(uint, uint, uint, uint, string memory) {
        return (characterData.balance, characterData.health, characterData.lastPaymentAmount, characterData.lastPaymentDate, characterData.username);
    }
}