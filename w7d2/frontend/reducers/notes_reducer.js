import {NotesConstants} from '../actions/note_actions';
import {validKeys, keyMap, NOTE_NAMES} from '../util/tones';

const NotesReducer = (state = [], action) => {
  switch (action.type) {
    case NotesConstants.KEY_PRESSED:
      if (!state.includes(action.key) && keyMap[action.key]) {
        return [...state, action.key];
      }
      return state;

    case NotesConstants.KEY_RELEASED:
      if (state.includes(action.key) && keyMap[action.key]) {
        const index = state.indexOf(action.key);
        const newState = [...state.slice(0, index),
                          ...state.slice(index + 1)];
        return newState;
      }
      return state;

    default:
      return state;
  }
};

export default NotesReducer;
