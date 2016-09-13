import React from 'react';
import Greeting from './greeting';

const App = ({children}) => (
  <div>
    <Greeting />
    <h1>
      {children}
    </h1>
  </div>
);

export default App;
