const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NftCollection", function () {
  let nft, owner, addr1, addr2;

  beforeEach(async function () {
    // 1. Get signers (wallets)
    [owner, addr1, addr2] = await ethers.getSigners();

    // 2. Get the Contract Factory
    const NftCollection = await ethers.getContractFactory("NftCollection");
    
    // 3. Deploy with the EXACT arguments from your Solidity constructor:
    // Arguments: (name, symbol, baseURI)
    nft = await NftCollection.deploy("TestNFT", "TNFT", "https://meta/");
    
    // 4. WAIT for the deployment to finish (This is the Ethers v6 way)
    await nft.waitForDeployment();
  });

  it("Should have correct name and symbol", async function () {
    expect(await nft.name()).to.equal("TestNFT");
    expect(await nft.symbol()).to.equal("TNFT");
  });

  it("Should allow owner to mint and track total supply", async function () {
    // Mint token ID #1 to addr1
    await nft.safeMint(addr1.address, 1);
    
    expect(await nft.ownerOf(1)).to.equal(addr1.address);
    expect(await nft.totalSupply()).to.equal(1n); // v6 returns BigInt, hence '1n'
  });

  it("Should prevent non-owners from minting", async function () {
    // Connect as addr1 (not the owner) and try to mint
    await expect(nft.connect(addr1).safeMint(addr2.address, 2))
      .to.be.revertedWithCustomError(nft, "OwnableUnauthorizedAccount");
  });
});