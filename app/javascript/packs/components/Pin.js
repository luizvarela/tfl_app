import React from 'react';
import Popup from './Popup';

const Pin = ({ text, location, $hover }) => {
  let style = {
    borderRadius: '50%',
    borderStyle: 'dotted',
    borderWidth: 2,
    borderColor: '#1f632d',
    position: 'relative',
    background: '#3ce35f',
    height: 18,
    width: 18,
    zIndex: 1,
  };

  style.zIndex = ($hover) ? 999 : 1

  return(
    <div style={style}>
      <Popup
        text={text}
        hover={$hover}
        location={location}
      />
    </div>
  );
}

export default Pin;
