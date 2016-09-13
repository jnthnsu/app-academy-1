import React from 'react';
import {logout as lgout} from '../actions/session_actions';
import {withRouter} from 'react-router';
import {connect} from 'react-redux';

const Greeting = ({currentUser, logout, router}) => {
  if (currentUser){
    return (
      <div>
        <h1>Hi {currentUser.username}</h1>
        <button onClick={logout}>Logout</button>
      </div>
    );
  } else {
    return (
      <div>
        <button onClick={() => router.push('signup')}>Signup</button>
        <button onClick={() => router.push('login')}>Login</button>
      </div>
    );
  }
};

const mapStatetoProps = state => ({
  currentUser: state.session.currentUser,
});

const mapDispatchtoProps = dispatch => ({
  logout: () => dispatch(lgout())
});

export default withRouter(connect(
  mapStatetoProps,
  mapDispatchtoProps
)(Greeting));
