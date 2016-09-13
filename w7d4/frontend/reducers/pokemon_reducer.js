import {PokemonActions} from '../actions/pokemon_actions';
import {merge} from 'lodash';

export const PokemonReducer = (state = {pokemons: [], currentPokemon: {}}, action) => {
  const newState = merge({}, state);

  switch(action.type){
    case PokemonActions.RECEIVE_ALL_POKEMON:
      newState.pokemons = [...newState.pokemons, ...action.pokemons];
      return newState;
    case PokemonActions.RECEIVE_A_POKEMON:
      newState.currentPokemon = action.pokemon;
      return newState;
    default:
      return state;
  }
};
