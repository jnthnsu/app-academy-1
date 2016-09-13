import React from 'react';
import {login, signup} from '../actions/session_actions';
import {withRouter} from 'react-router';
import {connect} from 'react-redux';

class SessionForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      username: '',
      password: ''
    };
  }

  handleSubmit(e){
    e.preventDefault();
    if (this.props.formType === 'login'){
      this.props.login({user: this.state});
    } else {
      this.props.signup({user: this.state});
    }
	}

	componentDidUpdate(){
		if (this.props.currentUser){
      this.props.router.push('/');
    }
	}

  update(property){
    return e => this.setState({[property]: e.target.value});
  }

  render(){
    return (
      <div>
        <h1>{this.props.formType}</h1>
        <form onSubmit={this.handleSubmit.bind(this)}>
          <input type='text' placeholder='username' value={this.state.username} onChange={this.update('username')}/>
          <input type='password' placeholder='password' value={this.state.password} onChange={this.update('password')}/>
          <input type='submit' value="Submit"/>
        </form>
      </div>
    );
  }

}

const mapStatetoProps = (state, ownProps) => ({
  currentUser: state.session.currentUser,
  errors: state.session.errors,
  formType: ownProps.location.pathname.slice(1)
});

const mapDispatchtoProps = dispatch => ({
  login: user => dispatch(login(user)),
  signup: user => dispatch(signup(user))
});

export default withRouter(connect(
  mapStatetoProps,
  mapDispatchtoProps
)(SessionForm));
