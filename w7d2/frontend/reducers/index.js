import {combineReducers} from 'redux';
import NotesReducer from './notes_reducer';
import TracksReducer from './tracks_reducer';
import IsRecordingReducer from './is_recording_reducer';

export default combineReducers({
  notes: NotesReducer,
  tracks: TracksReducer,
  isRecording: IsRecordingReducer
});
