import {createStore, applyMiddleware} from 'redux';
import {PokemonReducer} from '../reducers/pokemon_reducer';
import PokemonMiddleware from '../middleware/pokemon_middleware';

export default () => (
  createStore(PokemonReducer, applyMiddleware(PokemonMiddleware))
);
