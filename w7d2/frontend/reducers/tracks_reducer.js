import {TracksConstants} from '../actions/tracks_actions';
import merge from 'lodash/merge';

const TracksReducer = (state = {}, action) => {
  let currTrackId = 0;

  const newState = merge({}, state);
  switch (action.type){
    case TracksConstants.START_RECORDING:
      currTrackId += 1;

      newState[currTrackId] = {
        id: currTrackId,
        name: `Track ${currTrackId}`,
        roll:[],
        timeStart: action.timeNow
      };

      return newState;

    case TracksConstants.STOP_RECORDING:
      newState[currTrackId].roll.push({
        notes: [],
        timeSlice: action.timeNow - state[currTrackId].timeStart
      });

      return newState;

    case TracksConstants.ADD_NOTES:
      newState[currTrackId].roll.push({
        notes: action.notes,
        timeSlice: action.timeNow - state[currTrackId].timeStart
      });

      return newState;

    default:
      return state;
  }
};

export default TracksReducer;
