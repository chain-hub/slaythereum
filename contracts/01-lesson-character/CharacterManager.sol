// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./Character.sol";

contract Manager {
    mapping(string => address) public characters;

    function crateCharacter(string memory name) public returns (address) {
        address newCharacter = address(new Character(name, msg.sender));
        characters[name] = newCharacter;
        return address(newCharacter);
    }

    function getCharacterData(string memory name) public view returns (uint, uint, uint, uint, string memory) {
        address characterAddress = characters[name];
        require(characterAddress != address(0));
        Character character = Character(characterAddress);
        (uint balance, uint health, uint lastPaymentAmount, uint lastPaymentDate, string memory username) = character.getCharacterData();
        return (
            balance,
            health,
            lastPaymentAmount,
            lastPaymentDate,
            username
        );
    }
}