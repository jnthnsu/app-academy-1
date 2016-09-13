import React from 'react';
import {connect} from 'react-redux';
import {requestBenches as reqBenches} from '../actions/bench_actions';
import {updateBounds as updBounds} from '../actions/filter_actions';
import BenchMap from './bench_map';
import BenchIndex from './bench_index';

const Search = ({benches, requestBenches, updateBounds}) => (
  <div>
    <BenchMap benches={benches} updateBounds={updateBounds}/>
    <BenchIndex benches={benches} requestBenches={requestBenches}/>
  </div>
);

const mapStatetoProps = state => ({
  benches: state.benches
});

const mapDispatchtoProps = dispatch => ({
  requestBenches: () => dispatch(reqBenches()),
  updateBounds: bounds => dispatch(updBounds(bounds))
});

export default connect(
  mapStatetoProps,
  mapDispatchtoProps
)(Search);
