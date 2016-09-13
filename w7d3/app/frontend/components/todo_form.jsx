import React from 'react';

export class TodoForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      title: props.title,
      body: props.body
    };
  }

  render(){
    return (
      <form>
        <input type='text' value={this.state.title}
               placeholder="Title"
               onChange={ e => this.setState({title: e.target.value}) }>
        </input>

        <input type='text' value={this.state.body}
               placeholder="Body"
               onChange={ e => this.setState({body: e.target.value}) }>
        </input>

        <input type="button"
               onClick={ () => this.props.action({todo: this.state}) }>
        </input>
    </form>);
  }
}
