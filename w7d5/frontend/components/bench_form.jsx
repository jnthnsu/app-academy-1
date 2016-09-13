import React from 'react';
import {connect} from 'react-redux';
import {withRouter} from 'react-router';
import {createBench} from '../actions/bench_actions';

class BenchForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      description: '',
      seating: 0,
      lat: this.props.lat,
      lng: this.props.lng
    };
  }

  handleSubmit(e){
    e.preventDefault();
    this.props.createBench({bench: this.state});
    this.props.router.push('/');
  }

  update(property){
    return e => this.setState({[property]: e.target.value});
  }

  render(){
    return (
      <form onSubmit={this.handleSubmit.bind(this)}>
        <input type='text' placeholder='description' value={this.state.description} onChange={this.update('description')}/>
        <input type='number' placeholder='seating' value={this.state.seating} onChange={this.update('seating')}/>
        <input type='number' placeholder='latitude' value={this.state.lat} onChange={this.update('lat')}/>
        <input type='number' placeholder='longitude' value={this.state.lng} onChange={this.update('lng')}/>
        <input type='submit' value="Submit"/>
      </form>
    );
  }
}

const mapStatetoProps = (state, ownProps) => ({
  lat: ownProps.location.query.lat,
  lng: ownProps.location.query.lng
});

const mapDispatchtoProps = dispatch => ({
  createBench: data => dispatch(createBench(data))
});

export default withRouter(connect(
  mapStatetoProps,
  mapDispatchtoProps
)(BenchForm));
