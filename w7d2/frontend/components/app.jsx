import React from 'react';
import Synth from './synth/synth';
import SynthContainer from './synth/synth_container';


class App extends React.Component {
  render() {
    return (
      <div>
        <SynthContainer />
        <RecorderContainer />
      </div>
    );
  }
}

export default App;
