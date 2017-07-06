import React from 'react';

const popupBody = (text, location) => (
  <div style={{
    borderRadius: '2.5%',
    minHeight: 50,
    width: 300,
    background: '#212237',
    padding: 5,
    textAlign: 'justify',
  }}>
    <div style={{
      width: 300,
      paddingTop: 5,
      background: '#636473',
      textAlign: 'center',
      verticalAlign: 'middle',
      color: '#fff',
      fontWeight: 'bold',
      fontSize: 20,
    }}>
      {location}
    </div>
    <div style={{
      padding: 5,
      textAlign: 'justify',
      color: '#fff',
      fontSize: 12,
      wordWrap: 'break-word',
    }}>
      {text}
    </div>
  </div>
);

const Popup = ({ text, location, hover }) => {
  return (hover)? popupBody(text, location) : null
}

export default Popup;
