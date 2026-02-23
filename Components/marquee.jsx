import React from 'react';
import { withComponentFeatures } from 'universal-dashboard';

const UDMarquee = (props) => {

  const normalizeMessages = () => {
    if (!props.messages) return [];

    if (Array.isArray(props.messages)) return props.messages;

    return [props.messages];
  };

  const messages = normalizeMessages();

  const text = messages

  const speed = props.speed || 40;

  const containerStyle = {
    overflow: "hidden",
    whiteSpace: "nowrap",
    width: "100%",
    backgroundColor: "#013D5B",
    color: "#ffffff",
    padding: "6px 0",
    position: "relative",
    fontSize: props.fontSize || "14px",
    borderRadius: "5px"
  };

  const trackStyle = {
    display: "inline-block",
    whiteSpace: "nowrap",
    paddingLeft: "100%",
    animation: `scroll ${speed}s linear infinite`
  };

  return (
    <div style={containerStyle}>
      <style> {`
          @keyframes scroll {
              0%   { transform: translateX(0); }
              100% { transform: translateX(-100%); }
          }
        `} </style>
      <div style={trackStyle}>
        {text.map((msg, i) => (
          <span key={i} style={{ marginRight: "50px" }}>
            {msg}
          </span>
        ))}
      </div>
    </div>
  );
};

export default withComponentFeatures(UDMarquee);
