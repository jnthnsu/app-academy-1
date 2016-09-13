import {BenchActions, requestBenches, receiveBenches, receiveBench} from '../actions/bench_actions';
import {FilterActions} from '../actions/filter_actions';
import * as BenchAPI from '../util/bench_api_util';

const BenchesMiddleware = ({getState, dispatch}) => next => action => {
  let success = benches => {
    return dispatch(receiveBenches(benches));
  };

  switch(action.type){
    case BenchActions.REQUEST_BENCHES:
      const filters = getState().filters;
      BenchAPI.requestBenches(filters, success);
      return next(action);
    case FilterActions.UPDATE_BOUNDS:
      dispatch(requestBenches());
      return next(action);
    case BenchActions.CREATE_BENCH:
      success = bench => dispatch(receiveBench(bench));
      BenchAPI.createBench(action.bench, success);
      return next(action);
    default:
      return next(action);
  }
};

export default BenchesMiddleware;
