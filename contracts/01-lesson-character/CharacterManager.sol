// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Character.sol";

contract CharacterManager {
    mapping(string => address) public characters;

    function createCharacter(string memory username) external returns (address) {
        require(characters[username] == address(0), "Character already exists");
        
        Character newCharacter = new Character(username);
        characters[username] = address(newCharacter);

        return address(newCharacter);
    }

    function getCharacterData(string memory username) external view returns (uint256, uint256, uint256, uint256) {
        address characterAddress = characters[username];
        require(characterAddress != address(0), "Character does not exist");

        Character character = Character(characterAddress);
        return character.getCharacterData();
    }
}