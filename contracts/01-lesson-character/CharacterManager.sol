contract CharacterManager{
    Character[] public characterCreate;
    mapping(string => address) public characters;

    function createCharacter(string memory NewCharacter) public returns(address){ 
        Character newCharacter = new Character(NewCharacter); 
        characters[NewCharacter] = address(newCharacter); 
        characterCreate.push(newCharacter); 
        require(msg.sender != address(0), "Error");
        return address(newCharacter); 
    } 

    function getCharacterData(string memory _name) public view returns(uint256 balance, uint256 health, uint256 lastPaymentDate, uint256 lastPaymentAmount){  
       Character character = Character(characters[_name]);  
       (balance, health, lastPaymentDate, lastPaymentAmount) = character.characterdata();
       return (balance, health, lastPaymentDate, lastPaymentAmount);  
   } 
}