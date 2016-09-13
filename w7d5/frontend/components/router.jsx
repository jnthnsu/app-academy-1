import React from 'react';
import {Router, Route, IndexRoute, hashHistory} from 'react-router';
import App from './app';
import Search from './search';
import BenchForm from './bench_form';
import SessionForm from './session_form';

class AppRouter extends React.Component{
	constructor(props){
		super(props);
	}

  _ensureLoggedIn(e, replace){
    if (!this.context.store.getState().session.currentUser){
      replace('login');
    }
  }

	render(){
		return (
	    <Router history={hashHistory}>
	      <Route path='/' component={App}>
	        <IndexRoute component={Search} />
	        <Route path='benches/new' component={BenchForm} onEnter={this._ensureLoggedIn.bind(this)} />
	        <Route path='login' component={SessionForm} />
	        <Route path='signup' component={SessionForm} />
	      </Route>
	    </Router>
	  );
	}
}

AppRouter.contextTypes = {
  store: React.PropTypes.object.isRequired
};

export default AppRouter;
