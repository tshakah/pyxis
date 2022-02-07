import React, {FC, ReactElement} from "react";
import {IconAlert, IconCheckCircle, IconClose, IconExclamationCircle, IconThumbUp} from "components/Icon/Icons";
import classNames from "classnames";
import "./Message.module.scss";

// TODO: remove this implementation when message will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

export const messages = (withBackground?:boolean) => (
  <>
    {!withBackground && <Message/>}
    <Message state="brand" withBackground={withBackground} />
    {withBackground && <Message state="alert" withBackground={withBackground}/>}
    <Message state="success" withBackground={withBackground} />
    <Message state="error" withBackground={withBackground} />
  </>
)

const classes = (ghost:boolean, withBackground:boolean, state?: string):string => classNames(
  "message",
  {
    [`message--${state}`]: state,
    "message--ghost": ghost,
    "message--with-background-color": withBackground && state
  }
)

const setIcon = (state?: string):ReactElement => {
  switch (state) {
    case "brand":
      return <IconThumbUp />;
    case "success":
      return <IconCheckCircle description={"Success."}/>;
    case "alert":
      return <IconAlert description={"Attention!"}/>;
    default:
      return <IconExclamationCircle description={state === "error" ? "Error." : undefined}/>
  }
}

const Message:FC<MessageProps> =
  ({
     state,
     ghost= false,
     withClose= false,
     withBackground= false,
     withTitle= true
  }) => (
  <div className={classes(ghost, withBackground, state)} role={state === "error" ? "alert" : "status"}>
    <div className="message__icon">
      {setIcon(state)}
    </div>
    <div className="message__content-wrapper">
      {withTitle && !ghost && <div className="message__title">Title message</div>}
      <div className="message__text">Text message - {state ? state : "neutral"}</div>
    </div>
    {!ghost && withClose &&
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
  withClose?: boolean,
  withTitle?: boolean
}

export default Message;