import React from 'react';
import {connect} from 'react-redux';
import {withRouter} from 'react-router';

const Pokedex = ({pokemons, children}) => {
  const pokemonElements = pokemons.map(pokemon => (
    <PokedexItem pokemon={pokemon} key={pokemon.id}/>
  ));

  return (
    <div className='pokedex'>
      <ul>
        {pokemonElements}
      </ul>
      {children}
    </div>
  );
};

const PokedexItem = withRouter(({pokemon, router}) => (
  <li className="pokemon-index-item" onClick={() => router.push(`/pokemon/${pokemon.id}`)}>
    <span>{pokemon.id}</span>
    <img src={pokemon.image_url}/>
    <span>{pokemon.name}</span>
  </li>
));

const mapStatetoProps = state => ({
  pokemons: state.pokemons
});

export default connect(
  mapStatetoProps
)(Pokedex);
