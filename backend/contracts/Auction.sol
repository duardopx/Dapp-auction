pragma solidity ^0.8.0;

// import './PokemonNFT.sol';

contract Auction {

 struct Pokemon {
    uint nft;
    uint biggestBid;
    address biggestBidder;
}

  address auctioneer;
  bool auctionIsRunning;

  address biggestBidder;
  uint biggestBid;

  mapping(address => uint) balances;
  address [] offerers;

  mapping(uint => Pokemon) pokemons;

  modifier 

  constructor() {
    auctionIsRunning = true;
    auctioneer = msg.sender;
    initialBids();
  }

  function pokemonOffers(uint id) public view returns(uint, uint, address) {
    return (pokemons[id].nft, pokemons[id].biggestBid, pokemons[id].biggestBidder);
  }
    
  event logBiggestOfferCovered(address newBiggestOfferer, uint newBiggestOffer);

  function bid(uint id) public payable {
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
    for (uint tokenId = 1; tokenId <= 4; tokenId++) {
      pokemons[tokenId] = Pokemon(createPokemonNFT(string(tokenId)),
                                  (base % (tokenId + 1000)) + 500, msg.sender);
    }
  }

  function EndAuction() public view returns (uint, address) {
    require(!auctionIsRunning, "The auction was already finished");
    auctionIsRunning = false;

    return(biggestBid, biggestBidder);
  }

  function isAuctioner() public view returns(bool) {
    return msg.sender == auctioneer;
  }

  function contractBalance() public view returns(uint) {
    return address(this).balance;
  }
}
