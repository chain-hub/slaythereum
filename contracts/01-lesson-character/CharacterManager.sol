// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Character.sol";

contract Manager {
    mapping(string => address) public characters;

    function createCharacter(string memory username) public returns (address) {
        require(characters[username] == address(0), "Character already exists");
        
        Character newCharacter = new Character(username, msg.sender);
        characters[username] = address(newCharacter);

        return address(newCharacter);
    }

    function getCharacterData(string memory username) public view returns (uint256, uint256, uint256, uint256, string memory) {
        address characterAddress = characters[username];
        require(characterAddress != address(0), "Character does not exist");

        Character character = Character(characterAddress);
        return character.getCharacterData();
    }
}