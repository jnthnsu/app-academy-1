import React from 'react';
import {App} from './app';
import {Provider} from 'react-redux';

export const Root = ({store}) => (
  <Provider store={store}>
    <App />
  </Provider>
);
