pragma solidity ^0.8.0;

//import './PokemonNFT.sol';

contract Auction {

  // using Counters for Counters.Counter;
  // Counters.Counter private tokenIds;

 struct Pokemon {
    bytes32 nft;
    uint biggestBid;
    address biggestBidder;
}

  address auctioneer;
  bool auctionIsRunning;

  address biggestBidder;
  uint biggestBid;

  uint constant pokemonNumber = 3;

  mapping(uint => Pokemon) pokemons;
  

  constructor() {
    auctionIsRunning = true;
    auctioneer = msg.sender;
    initialBids();
    }
    
    event logBiggestOfferCovered(address newBiggestOfferer, uint newBiggestOffer);


  function createPokemonNFT(uint pokemonId) private pure returns(bytes32) {
      return keccak256(abi.encodePacked(pokemonId));
  }

  function pokemonOffers(uint id) public view returns(bytes32, uint, address) {
    return (pokemons[id].nft, pokemons[id].biggestBid, pokemons[id].biggestBidder);
  }
    

  function bid(uint id) public payable {
    require(pokemonNumber >= id, "The searched pokemon does not exist");
    require(pokemons[id].biggestBid <= msg.sender.balance, "Your balaces is't enough");
    require(pokemons[id].biggestBid < msg.value);

    payable(pokemons[id].biggestBidder).transfer(pokemons[id].biggestBid);

    pokemons[id].biggestBidder = msg.sender;
    pokemons[id].biggestBid = msg.value;

    emit logBiggestOfferCovered(pokemons[id].biggestBidder, pokemons[id].biggestBid);
  }

  function initialBids() private  {
    require(auctioneer == msg.sender, "Only the auctioneer can set it");

    uint base = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
    
    for (uint tokenId = 1; tokenId <= pokemonNumber; tokenId++) {
      pokemons[tokenId] = Pokemon(createPokemonNFT(tokenId), (base % (tokenId + 1000)) + 300, msg.sender);
    }
  }

  function checkWinner() public view returns (uint, address) {
    require(auctionIsRunning == false, "The auction need to be ended");

    return(biggestBid, biggestBidder);
  }
  
//  function auctionEnd() public {
//      require(auctioneer == msg.sender, "Only the auctioneercan handle it");
//      auctionIsRunning = false;
//      
//      for (uint pokemon = 1; pokemon < pokemonNumber; i++) {
//          sender
//      }
  //}

  function isAuctioner() public view returns(bool) {
    return msg.sender == auctioneer;
  }

    //debug
  function contractBalance() public view returns(uint) {
    return address(this).balance;
  }
}

