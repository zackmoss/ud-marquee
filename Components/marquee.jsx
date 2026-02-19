import React from "react";
import { withComponentFeatures } from "universal-dashboard";

const UDMarquee = (props) => {
  const normalizeMessages = () => {
    if (!props.messages) return [];

    if (Array.isArray(props.messages)) {
      return props.messages;
    }

    return [props.messages];
  };

  const messages = normalizeMessages();
  const [index, setIndex] = useState(0);

  useEffect(() => {
    if (messages.length <= 1) return;

    const interval = setInterval(() => {
      setIndex((prev) => (prev + 1) % messages.length);
    }, props.rotateInterval || 5000);

    return () => clearInterval(interval);
  }, [messages]);

  const speed = props.speed || 20;

  const containerStyle = {
    overflow: "hidden",
    whiteSpace: "nowrap",
    width: "100%",
    background: props.backgroundColor || "#111",
    color: props.color || "#fff",
    padding: "6px 0",
    position: "relative",
  };

  const textStyle = {
    display: "inline-block",
    paddingLeft: "100%",
    animation: `scroll ${speed}s linear infinite`,
  };

  return (
    <div style={containerStyle}>
      <style>
        {`
                @keyframes scroll {
                    0%   { transform: translateX(0); }
                    100% { transform: translateX(-100%); }
                }
                `}
      </style>

      <div style={textStyle}>{messages[index] || ""}</div>
    </div>
  );
};

export default withComponentFeatures(UDMarquee);
