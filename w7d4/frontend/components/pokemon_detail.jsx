import React from 'react';
import {connect} from 'react-redux';
import {withRouter} from 'react-router';

const PokemonDetail = ({currentPokemon, router, children}) => {
  let {id, name, poke_type, image_url, attack, defense, moves, toys} = currentPokemon;

  if (toys === undefined){
    toys = [];
  }

  const toyImages = toys.map((toy, idx) => (
    <img src={toy.image_url} onClick={() => router.push(`/pokemon/${id}/toys/${idx}`)} key={idx}/>
  ));

  return (
    <section className="pokemon-detail">
      <ul>
        <img src={image_url} alt=""/>
          <li><h2>{name}</h2></li>
          <li>Type: {poke_type}</li>
          <li>Attack: {attack}</li>
          <li>Defense: {defense}</li>
          <li>Moves: &#34;{moves}&#34;</li>
        <section className="toys">
            <h3>Toys</h3>
          <div className="toys">
            {toyImages}
            {children}
          </div>
        </section>
      </ul>
    </section>
  );
};


const mapStatetoProps = state => ({
  currentPokemon: state.currentPokemon
});

export default withRouter(connect(
  mapStatetoProps
)(PokemonDetail));
