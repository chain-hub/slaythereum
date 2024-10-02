// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./Character.sol";

contract Manager {

    mapping(string => address) public characters;

    function crateCharacter(string memory _username) public returns(address)  {
        require(characters[_username] == address(0));
        Character newCharacter = new Character(_username, msg.sender);
        characters[_username] = address(newCharacter);
        return address(newCharacter);
    }

    function getCharacterData(string memory _username) public view returns(uint, uint, uint, uint, string memory) {
        address characterAddress = characters[_username];
        require(characterAddress != address(0));
        Character character = Character(characterAddress);
        (uint balance, uint health, uint lastPaymentDate, uint lastPaymentAmount, string memory username) = character.getCharacterData();
        return (balance, health, lastPaymentDate, lastPaymentAmount, username);
    }
}