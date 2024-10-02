import {loadFixture} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import {expect} from "chai";
import hre from "hardhat";

describe("Manager", function () {
    async function deployManagerFixture() {
        const [owner, otherAccount] = await hre.ethers.getSigners();

        const Manager = await hre.ethers.getContractFactory("Manager");
        const manager = await Manager.deploy();
        await manager.getDeployedCode();

        return {manager, owner, otherAccount};
    }

    describe("Character Creation", function () {
        it("Should create a new character", async function () {
            const {manager} = await loadFixture(deployManagerFixture);

            const tx = await manager.crateCharacter("Hero");
            await tx.wait();
            const characterAddress = await manager.characters("Hero");

            expect(characterAddress).to.not.equal(hre.ethers.ZeroAddress);
        });
    });

    describe("Fetching Character Data", function () {
        it("Should return character data for a valid character", async function () {
            const {manager} = await loadFixture(deployManagerFixture);

            await manager.crateCharacter("Hero");
            const characterData = await manager.getCharacterData("Hero");

            expect(characterData[1]).to.equal(100); // Health should be 100
        });
    });
});
