import {connect} from 'react-redux';
import React from 'react';
import Note from '../../util/note';
import {freqToKeyMap, TONES, NOTE_NAMES} from '../../util/tones';
import $ from 'jquery';
import NoteKey from './note_key';

class Synth extends React.Component{
  constructor(props) {
    super(props);
    this.notes = NOTE_NAMES.map(note => ({
        noteInstance: new Note(TONES[note]),
        name: note,
        freq: TONES[note],
        key: freqToKeyMap[TONES[note]]
      })
    );
  }

  componentDidMount() {
    $(document).on('keydown', e => this.onKeyDown(e));
    $(document).on('keyup', e => this.onKeyUp(e));
  }

  onKeyUp(e) {
    let key = String.fromCharCode(e.keyCode).toLowerCase();
    this.props.keyReleased(key);
  }

  onKeyDown(e) {
    let key = String.fromCharCode(e.keyCode).toLowerCase();
    this.props.keyPressed(key);
  }

  playNotes() {
    this.notes.forEach(note => {
      if (this.props.notes.includes(note.key)){
        note.noteInstance.start();
      } else {
        note.noteInstance.stop();
      }
    });
  }

  render() {
    const notes = this.notes.map((note, idx) => (
      <NoteKey noteName={note.name} key={note.name}/>
    ));

    this.playNotes();

    return (
      <ul>
        {notes}
      </ul>
    );
  }
}

export default Synth;
