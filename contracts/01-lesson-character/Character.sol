// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Character {

    address public owner;

    constructor (string memory name, address _owner) {
        owner = _owner;
        characters.push(CharacterData(0, 100, 0, 0, name));
    }

    struct CharacterData {
        uint balance;
        uint health;
        uint lastPaymentDate;
        uint lastPaymentAmount;
        string username;
    }

    CharacterData[] public characters;

    modifier OnlyOwner() {
        require(owner == msg.sender, "Not Owner");
        _;
    }

    function deposit() payable public {
        require(msg.value > 0.01 ether, 'error deposit');
        CharacterData storage character = characters[0];
        character.balance = msg.value;
        character.lastPaymentDate = block.timestamp;
    }

    function increaseHealth(uint heal) public OnlyOwner returns(uint)  {
        CharacterData storage character = characters[0];
        require(character.balance > 0.001 ether, "error health");
        uint cost = heal * 0.001 ether;
        character.balance -= cost;
        (bool succses, ) = address(0x0000000000000000000000000000000000000000).call{value: cost}("");
        require(succses, "ETH burn failed");
        character.health += heal;
        return character.health;
    }

    function getCharacterData() public view returns (uint, uint, uint, uint, string memory) {
        return (characters[0].balance, characters[0].health, characters[0].lastPaymentDate, characters[0].lastPaymentAmount, characters[0].username);
    }

}