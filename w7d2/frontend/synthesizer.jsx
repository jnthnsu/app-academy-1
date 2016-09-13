import React from 'react';
import ReactDOM from 'react-dom';
import Note from './util/note';
import {TONES, NOTE_NAMES} from './util/tones';
import configureStore from './store/store';
import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  console.log(store.getState());
  const rootEl = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, rootEl);
});
