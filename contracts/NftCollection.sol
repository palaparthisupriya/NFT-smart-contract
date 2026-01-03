// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NftCollection is ERC721, Pausable, Ownable {
    using Strings for uint256;

    uint256 public constant MAX_SUPPLY = 1000;
    uint256 public totalSupply;
    string private _baseTokenURI;

    // Events for transparency
    event TokenMinted(address indexed owner, uint256 indexed tokenId);

    constructor(
        string memory name, 
        string memory symbol, 
        string memory baseURI
    ) ERC721(name, symbol) Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }

    /**
     * @dev Mint a new NFT. Only the owner can mint.
     * Prevents minting when the contract is paused.
     */
    function safeMint(address to, uint256 tokenId) public onlyOwner whenNotPaused {
        require(tokenId > 0 && tokenId <= MAX_SUPPLY, "Invalid tokenId: Out of range");
        require(totalSupply < MAX_SUPPLY, "Collection: Max supply reached");
        // ERC721 internal check will handle "Token already minted" revert
        
        totalSupply++;
        _safeMint(to, tokenId);
        
        emit TokenMinted(to, tokenId);
    }

    // Administrative functions
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // Metadata logic
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId); // OZ 5.x internal check for existence
        return string(abi.encodePacked(_baseURI(), tokenId.toString(), ".json"));
    }

    // Required overrides for inheritance
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}