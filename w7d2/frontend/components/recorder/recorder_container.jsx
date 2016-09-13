import {connect} from 'react-redux';
import Recorder from './recorder';
import {startRecording, stopRecording, addNotes} from '../../actions/tracks_actions';

const mapStateToProps = (state) => ({
  notes: state.notes,
  tracks: state.tracks,
  isRecording: state.isRecording
});

const mapDispatchToProps = (dispatch) => ({
  startRecording: () => dispatch(startRecording()),
  stopRecording: () => dispatch(stopRecording()),
  addNotes: (notes) => dispatch(addNotes(notes))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Recorder);
