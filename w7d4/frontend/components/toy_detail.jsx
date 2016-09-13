import React from 'react';
import {connect} from 'react-redux';

const ToyDetail = ({toy_id}) => ( //how to find toy?
  <ul className='toy-detail'>
    <li><h2>{toy.name}</h2></li>
    <li>Happiness: {toy.happiness}</li>
    <li>Price: {toy.price}</li>
  </ul>
);

const mapStatetoProps = (state, {toy_id}) => ({
  toy_id
});

export default connect(
  mapStatetoProps
)(ToyDetail);
