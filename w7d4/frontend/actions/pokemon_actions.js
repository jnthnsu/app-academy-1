export const PokemonActions = {
  RECEIVE_ALL_POKEMON: 'RECEIVE_ALL_POKEMON',
  FETCH_ALL_POKEMON: 'FETCH_ALL_POKEMON',
  RECEIVE_A_POKEMON: 'RECEIVE_A_POKEMON',
  FETCH_A_POKEMON: 'FETCH_A_POKEMON',
};

export const receiveAllPokemon = pokemons => ({
  type: PokemonActions.RECEIVE_ALL_POKEMON,
  pokemons
});

export const fetchAllPokemon = () => ({
  type: PokemonActions.FETCH_ALL_POKEMON,
});

export const receiveAPokemon = pokemon => ({
  type: PokemonActions.RECEIVE_A_POKEMON,
  pokemon
});

export const fetchAPokemon = id => ({
  type: PokemonActions.FETCH_A_POKEMON,
  id
});
