// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SeafluxNFT is ERC1155, Ownable, ERC1155Burnable {
    uint256 public mintPrice = 0.001 ether;
    string public name = "Seaflux NFT";
    uint256 public maxSupply=10000;
    uint256 internal totalMinted;

    constructor()
        ERC1155("https://ipfs.io/ipfs/QmRyFNM4yS2Le6FHMb8KoFq7276NBNPZd5Hc5VmnukUoWT")
    {}

    function mint(uint256 numOfNFTs) external payable {
        require(totalMinted + numOfNFTs < maxSupply,"Minting would exceed max supply");
        require(mintPrice * numOfNFTs <= msg.value,"Not enough MATIC sent");
        require(numOfNFTs <= 10,"Only up to 10 NFTs can be minted");
        _mint(msg.sender, 1, numOfNFTs, "");
        totalMinted += numOfNFTs;
    }

    function getTotalSupply() external view returns (uint256) {
        return maxSupply;
    }

    function getMinted() external view returns (uint256) {
        return totalMinted;
    }


    function withdraw() public onlyOwner {
        require(address(this).balance > 0);
        uint256 contractBalance = address(this).balance;
        payable(_msgSender()).transfer(contractBalance);
    }

}
