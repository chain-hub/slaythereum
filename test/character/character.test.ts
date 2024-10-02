import {loadFixture} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import {expect} from "chai";
import hre, {ethers} from "hardhat";

describe("Character", function () {
    // Define fixture for deploying the Character contract
    async function deployCharacterFixture() {
        const [owner, otherAccount] = await hre.ethers.getSigners();

        const Character = await hre.ethers.getContractFactory("Character");
        const character = await Character.deploy("Hero", owner.address);
        await character.waitForDeployment();

        return {character, owner, otherAccount};
    }

    describe("Deployment", function () {
        it("Should initialize character with correct data", async function () {
            const {character} = await loadFixture(deployCharacterFixture);

            const [balance, health, lastPaymentDate, lastPaymentAmount, username] = await character.getCharacterData();
            expect(balance).to.equal(0);
            expect(health).to.equal(100);
            expect(username).to.equal("Hero");
        });
    });

    describe("Deposits", function () {
        it("Should accept deposits greater than 0.01 ETH", async function () {
            const {character, otherAccount} = await loadFixture(deployCharacterFixture);

            await character.connect(otherAccount).deposit({value: ethers.parseEther("0.02")});
            const [balance] = await character.getCharacterData();
            expect(balance).to.equal(ethers.parseEther("0.02"));
        });

        it("Should revert for deposits less than 0.01 ETH", async function () {
            const {character, otherAccount} = await loadFixture(deployCharacterFixture);

            await expect(
                character.connect(otherAccount).deposit({value: ethers.parseEther("0.005")})
            ).to.be.revertedWith("error deposit");
        });
    });

    describe("Increase Health", function () {
        it("Should allow the owner to increase health", async function () {
            const {character, owner} = await loadFixture(deployCharacterFixture);

            // Deposit some ETH to the character contract first
            await character.deposit({value: ethers.parseEther("0.05")});
            await character.increaseHealth(10);

            const [, health] = await character.getCharacterData();
            expect(health).to.equal(110); // Increased health by 10
        });

        it("Should revert if called by non-owner", async function () {
            const {character, otherAccount} = await loadFixture(deployCharacterFixture);

            await expect(character.connect(otherAccount).increaseHealth(10)).to.be.revertedWith("Not Owner");
        });

        it("Should revert if insufficient funds for health increase", async function () {
            const {character} = await loadFixture(deployCharacterFixture);

            await expect(character.increaseHealth(1)).to.be.revertedWith("error health");
        });
    });
});