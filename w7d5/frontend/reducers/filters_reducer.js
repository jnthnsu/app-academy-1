import {FilterActions} from '../actions/filter_actions';
import {merge} from 'lodash';

const FiltersReducer = (state = {bounds: []}, action) => {
  const newState = merge({}, state);

  switch(action.type){
    case FilterActions.UPDATE_BOUNDS:
      newState.bounds = action.bounds;
      return newState;
    default:
      return state;
  }
};

export default FiltersReducer;
