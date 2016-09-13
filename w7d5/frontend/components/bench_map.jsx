import React from 'react';
import MarkerManager from '../util/marker_manager';
import {withRouter} from 'react-router';

class BenchMap extends React.Component{
  constructor(props){
    super(props);
  }

  componentDidMount(){
    const mapDOMNode = this.refs.map;

    const mapOptions = {
      center: {lat: 37.7758, lng: -122.435},
      zoom: 13
    };

    this.map = new google.maps.Map(mapDOMNode, mapOptions);

    google.maps.event.addListener(this.map, 'idle', () => {
      let bounds = this.map.getBounds();
      bounds = [bounds.getNorthEast(), bounds.getSouthWest()];
      bounds = bounds.map(bound => [bound.lat(), bound.lng()]);

      this.props.updateBounds(bounds);
    });

    this.map.addListener('click', e => {
      let coords = {lat: e.latLng.lat(), lng: e.latLng.lng()};
      this.props.router.push({
        pathname: 'benches/new',
        query: coords
      });
    });


    this.MarkerManager = new MarkerManager(this.map);
  }

  componentWillReceiveProps(newProps){
    this.MarkerManager.updateMarkers(newProps.benches);
  }

  render(){
    return(
      <div id='map-container' ref='map'>
      </div>
    );
  }
}

export default withRouter(BenchMap);
