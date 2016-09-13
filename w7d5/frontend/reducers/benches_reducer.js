import {BenchActions} from '../actions/bench_actions';
import {merge} from 'lodash';

const BenchesReducer = (state = [], action) => {
  const newState = merge({}, {state: state});

  switch(action.type){
    case BenchActions.RECEIVE_BENCHES:
      return action.benches;
    case BenchActions.RECEIVE_BENCH:
      newState.state.push(action.bench);
      return newState.state;
    default:
      return state;
  }
};

export default BenchesReducer;
