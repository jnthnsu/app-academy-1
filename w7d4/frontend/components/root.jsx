import React from 'react';
import {Provider} from 'react-redux';
import Pokedex from './pokedex';
import PokemonDetail from './pokemon_detail';
import ToyDetail from './toy_detail';

import {Router, Route, hashHistory} from 'react-router';
import {fetchAllPokemon, fetchAPokemon} from '../actions/pokemon_actions';

export const Root = ({store}) => (
  <Provider store={store}>
    <Router history={hashHistory}>
      <Route onEnter={ () => store.dispatch(fetchAllPokemon()) } path='/' component={Pokedex}>
        <Route onEnter={ (nextState) => store.dispatch(fetchAPokemon(nextState.params.id)) } path='pokemon/:id' component={PokemonDetail}>
          <Route path='toys/:toy_id' component={ToyDetail}>

          </Route>
        </Route>
      </Route>
    </Router>
  </Provider>
);
