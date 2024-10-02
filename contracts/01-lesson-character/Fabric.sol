// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;  

import "https://github.com/str0nggyyy/enum_test/blob/main/enumtest.sol";
import "https://github.com/charmantemortt/game-solidity/blob/blockchain/minecraft.sol";
import "https://github.com/i4k1/buyer-contract/blob/main/buyer.sol";
 
contract Fabric{ 
    address public buyerContracts;
    address public minecraftContract;  
    address public enumTestContracts;

    function createMinecraft(string memory _address) public{ 
        Minecraft minecraft = new Minecraft(_address); 
        minecraftContract = address(minecraft); 
    } 

    function createBuyer(string memory _username, uint _age, uint _balance) public{
        Buyer buyer = new Buyer(_username, _age, _balance);
        buyerContracts = address(buyer);
    }

    function createEnumTest() public{
        EnumTest enumtest = new EnumTest();
        enumTestContracts = address(enumtest);
    }

    function changeMode(Minecraft.Mode _mode) public {
        require(minecraftContract != address(0), "Error"); 
        Minecraft minecraft = Minecraft(minecraftContract);
        minecraft.changeMode(_mode);
    }

    function changeStatus() public{
        require(buyerContracts != address(0), "Error"); 
        Buyer buyer = Buyer(buyerContracts);
        buyer.changeStatus();
    }

    function setUsername(string memory username) public{
        require(enumTestContracts != address(0), "Error"); 
        EnumTest enumtest = EnumTest(enumTestContracts);
        enumtest.setUsername(username);
    }
}