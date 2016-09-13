import React from 'react';
import ReactDOM from 'react-dom';
import Header from './header';

class Tabs extends React.Component{
  constructor({tabs}){
    super();
    this.tabs = tabs;
    this.state = {currentTab: 0};
  }

  changeTab(idx){
    this.setState({currentTab: idx});
  }

  render(){
    const tabs = this.tabs.map((tab, idx) => (
      <li key={tab.title}>
        <Header
          changeTab= {this.changeTab.bind(this, idx)}
          selected= {idx === this.state.currentTab}
          title= {tab.title}/>
        <article
          className= {idx === this.state.currentTab ? null : 'hidden'}>{tab.content}</article>
      </li>
    ));


    return (
      <ul>
        { tabs }
      </ul>
    );
  }
}

export default Tabs;
