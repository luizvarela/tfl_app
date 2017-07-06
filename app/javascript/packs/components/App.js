import React from 'react';
import { PulseLoader } from 'halogen';
import Map from './Map';

class App extends React.Component {
  constructor() {
    super();
    this.state = {
      data: null
    };
  }

  componentWillMount() {
    fetch('/disruptions')
      .then((response) => { return response.json() })
      .then((object) => { this.setState({ data: object }) });
  }

  render() {
    const apiKey = 'AIzaSyAX4shScV5CadaUtMCLxLd-E6jFWtfB7aE';
    const zoom = 11;
    const center = {lat: 51.512928, lng: -0.15989};
    const style = {
      height: 600,
      width: '100%',
      textAlign: 'center',
      background: '#363954',
    };

    if(!this.state.data) {
      return(
        <div style={style}>
          <div style={{padding: '10% 0'}}>
            <div style={{padding: '10% 0'}}>
              <PulseLoader color="#26A65B" size="16px" margin="4px" />
            </div>
          </div>
        </div>
      );
    }

    return(
      <div style={style}>
        <Map
          apiKey={apiKey}
          center={center}
          zoom={zoom}
          data={this.state.data}
        />
      </div>
    );

  }
}

export default App;
