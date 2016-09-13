import React from 'react';
// import ReactDOM from 'react-dom';

const Header = ({changeTab, selected, title}) => (
    <h1
      onClick= {changeTab}
      className= {selected ? 'selected' : 'unselected'}
    >
      {title}
    </h1>
);

export default Header;
