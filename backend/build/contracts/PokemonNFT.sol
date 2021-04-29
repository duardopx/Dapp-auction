pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PokemonNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private tokenIds;

    constructor() ERC721("poketoken", "pokemon") {}

    function createPokemonNFT(string memory tokenURI) public returns (uint) {
      tokenIds.increment();

      uint newPokemonNFT = tokenIds.current();
      _mint(msg.sender, newPokemonNFT);
      _setTokenURI(newPokemonNFT, tokenURI);

      return newPokemonNFT;
    }
}
