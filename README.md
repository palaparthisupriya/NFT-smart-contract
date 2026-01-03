
## NFT Collection Smart Contract
This repository contains a robust, ERC-721-compatible NFT smart contract built with Solidity and the Hardhat framework. The project is fully containerized using Docker to ensure a reproducible testing environment.

## Core Features
Standard Compliance: Fully implements the ERC-721 standard using OpenZeppelin v5.0 libraries.

Supply Management: Enforces a hard-coded MAX_SUPPLY of 1,000 tokens to ensure scarcity.

Access Control: Implements an Ownable pattern, restricting minting and administrative functions to the contract creator.

Emergency Stop: Includes Pausable functionality to halt minting operations if necessary.

Metadata Strategy: Utilizes a Base URI pattern with dynamic tokenId concatenation (e.g., https://meta/1.json) for gas-efficient metadata management.

## Project Structure
contracts/NftCollection.sol: The primary NFT smart contract logic.

test/NftCollection.test.cjs: Automated test suite covering success paths and edge cases.

Dockerfile: Configuration for the containerized test environment.

hardhat.config.js: Hardhat toolchain configuration.

## Docker Instructions 
The environment is designed to be built and run without any manual intervention or external dependencies.

1. Build the Image
This command compiles the contracts and installs all necessary dependencies (OpenZeppelin, Hardhat, Ethers.js) within the container.
docker build -t nft-contract .
2. Run the Tests
By default, running the container executes the complete automated test suite.
docker run nft-contract
