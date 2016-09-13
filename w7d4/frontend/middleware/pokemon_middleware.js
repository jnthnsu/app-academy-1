import * as API from '../util/api_util';
import {PokemonActions, receiveAllPokemon, receiveAPokemon} from '../actions/pokemon_actions';

export default ({dispatch}) => next => action => {
  let success = data => dispatch(receiveAllPokemon(data));

  switch(action.type){
    case PokemonActions.FETCH_ALL_POKEMON:
      API.fetchAllPokemon(success);
      return next(action);
    case PokemonActions.FETCH_A_POKEMON:
      success = data => dispatch(receiveAPokemon(data));
      API.fetchAPokemon(action.id, success);
      return next(action);
    default:
      return next(action);
  }
};
