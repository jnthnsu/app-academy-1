import React from 'react';
import ReactDOM from 'react-dom';

class Weather extends React.Component{
  constructor(){
    super();
    this.state = {date: new Date(), weather: ''};
  }

  componentDidMount() {
    this.handle = setInterval(() => this.setState({date: new Date()}), 1000);
    navigator.geolocation.getCurrentPosition(position => {
      let [lat, lon] = [position.coords.latitude, position.coords.longitude];
      let xml = new XMLHttpRequest();

      xml.onreadystatechange = function(){
        if(xml.readyState == XMLHttpRequest.DONE){
          this.setState({weather: JSON.parse(xml.responseText)});
        }
      }.bind(this);

      xml.open('GET', `http://api.apixu.com/v1/current.json?key=3a57dff55f514c16b66213308162208&q=${lat},${lon}`, true);
      xml.send();

    });
  }

  componentWillUnmount() {
    clearInterval(this.handle);
    this.handle = 0;
  }

  render(){
    return (
      <div>
        <p> {this.state.date.toString()} </p>
        <p> {
            this.state.weather ?
              this.state.weather.location.name + "\n" +
              this.state.weather.current.temp_f + ' degrees' :
              'loading weather...'
            }
        </p>
      </div>
    );
  }
}

export default Weather;
