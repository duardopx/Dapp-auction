const getPokemonUrl = id => `https://pokeapi.co/api/v2/pokemon/${id}`

const generatePokemonPromises = () => Array(3).fill().map((_, index) =>
  fetch(getPokemonUrl(index + 1)).then(response => response.json()))

const generateHTML = pokemons => pokemons.reduce((accumulator,{ name, id, types }) => {
  const elementTypes = types.map(typeInfo => typeInfo.type.name)

  accumulator += `
    <li class="card ${elementTypes[0]}">
    <img class="card-image" alt="${name}" src="https://pokeres.bastionbot.org/images/pokemon/${id}.png">
    <h2 class="card-title">${id}. ${name}</h2>
    <form action="/action_page.php">

    <input class="" placeholder="Cover current bid" id="${id}_pokemon">
    <button type="button">Submit</button>
    <p><strong>Biggest bet</strong>: 12300000 ether</p>
    <p><strong>Biggest better</strong>: 0xai292348address</p>
    </form>
    </li>
    `

  return accumulator

}, '')

const insertPokemonsIntoPage = pokemons => {
  const ul = document.querySelector('[data-js="pokedex"]')
  ul.innerHTML = pokemons
}

const pokemonPromises = generatePokemonPromises()

Promise.all(pokemonPromises)
  .then(generateHTML)
  .then(insertPokemonsIntoPage)

