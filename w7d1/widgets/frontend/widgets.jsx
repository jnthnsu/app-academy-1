import React from 'react';
import ReactDOM from 'react-dom';
import Tabs from './tabs';
import Weather from './weather';
import Autocomplete from './autocomplete';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  ReactDOM.render(<Widgets/>, root);

});

class Widgets extends React.Component{
  constructor(){
    super();
    this.tabs = [{title: 'a', content: 'asneietnga'},
      {title: 'b', content:'saeignag'}];
    this.users = ['Abba', 'Jeff', 'Sarah', 'Sally', 'Xander'];
  }

  render(){
    return (
      <div>
        <h1>Widgets</h1>
        <Tabs tabs={this.tabs}/>
        <Weather/>
        <Autocomplete users={this.users}/>
      </div>
    );
  }
}
