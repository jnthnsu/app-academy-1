import React from 'react';

class Autocomplete extends React.Component{
  constructor(props) {
    super(props);
    this.state = {input: ''};
    this.users = props.users;
  }


  handleChange(event) {
    this.setState({input: event.target.value});
  }


  render(){
    const users = this.users.map(user => (
      <li
        key={user}
        className={this.state.input.toLowerCase() === user.slice(0, this.state.input.length).toLowerCase() ?
        null : "hidden" }
      >
        {user}
      </li>
    ));

    return(
      <div>
        <input
          placeholder='Search...'
          onChange={this.handleChange.bind(this)}
        />
          <ul>
            {users}
          </ul>
      </div>
    );
  }
}

export default Autocomplete;
