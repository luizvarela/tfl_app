import React from 'react';
import GoogleMapReact from 'google-map-react';
import Pin from './Pin';

const disruptions = data =>
  data.map((disruption, i) => (
    <Pin
      key={i}
      lat={disruption.lat}
      lng={disruption.long}
      text={disruption.comments}
      location={disruption.location}
    />
  ))

const Map = ({ center, zoom, data, apiKey }) =>
  <GoogleMapReact
    bootstrapURLKeys={{key: apiKey}}
    defaultCenter={center}
    defaultZoom={zoom}
  >
    {disruptions(data)}
  </GoogleMapReact>


export default Map;
