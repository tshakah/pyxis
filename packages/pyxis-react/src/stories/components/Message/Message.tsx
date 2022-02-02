import {FC} from "react";
import {IconClose, IconThumbUp} from "components/Icon/Icons";
import classNames from "classnames";
import "./Message.scss";

// TODO: remove this implementation when message will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const Messages = () => (
  <div className="wrapper">
    <Message />
    <Message state="brand"/>
    <Message state="success"/>
    <Message state="error"/>

    <Message state="brand" withBackground />
    <Message state="alert" withBackground />
    <Message state="success" withBackground />
    <Message state="error" withBackground />

    <Message withTitle={false}/>
    <Message state="brand" withTitle={false}/>
    <Message state="success" withTitle={false}/>
    <Message state="error" withTitle={false}/>

    <Message state="brand" withTitle={false} withBackground/>
    <Message state="alert" withTitle={false} withBackground/>
    <Message state="success" withTitle={false} withBackground/>
    <Message state="error" withTitle={false} withBackground/>

    <Message ghost/>
  </div>
)

const classes = (ghost:boolean, withBackground:boolean, state?: string):string => classNames(
  "message",
  {
    [`message--${state}`]: state,
    "message--ghost": ghost,
    "message--with-background-color": withBackground && state
  }
)

const Message:FC<MessageProps> =
  ({
     state,
     ghost= false,
     withBackground= false,
     withTitle= true
  }) => (
  <div className={classes(ghost, withBackground, state)} role={state === "error" ? "alert" : "status"}>
    <div className="message__icon">
      <IconThumbUp size={"m"}/>
    </div>
    <div className="message__content-wrapper">
      {withTitle && !ghost && <div className="message__title">Title message</div>}
      <div className="message__text">Text message {state ? state : "neutral"}</div>
    </div>
    {!ghost &&
      <button className="message__close" onClick={() => alert("close")} aria-label="close" >
        <IconClose size={"s"}/>
      </button>
    }
  </div>
)

interface MessageProps {
  state?: "brand" | "alert" | "success" | "error",
  ghost?: boolean,
  withBackground?: boolean,
  withTitle?: boolean
}

export default Messages;