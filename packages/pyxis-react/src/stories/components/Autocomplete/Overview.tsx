import React, {FC} from "react";
import {IconAlert} from "components/Icon/Icons";
import Autocomplete from "./Autocomplete";

const Overview: FC = () => (
  <div className="form-grid form-grid--gap-large">

    <div className="message message--alert message--with-background-color">
      <div className="message__icon">
        <IconAlert description={"Attention!"}/>
      </div>
      <div className="message__content-wrapper">
        <div className="message__title">
          Non-exhaustive implementation
        </div>
        <div className="message__text">
          Made for HTML+SCSS testing purposes only.
        </div>
      </div>
    </div>

    <Autocomplete id="1" label="Default" />

    <Autocomplete id="2" label="With suggestion" withSuggestion />

    <Autocomplete id="3" label="With header" withHeader/>

    <Autocomplete id="4" label="With suggestion and header" withSuggestion withHeader/>

    <Autocomplete id="5" label="Disabled" disabled />

    <Autocomplete id="6" label="Small size" size="small" />

    <Autocomplete id="7" label="Small size with suggestion" size="small" withSuggestion />

    <Autocomplete id="8" label="Small size with header" size="small" withHeader/>

    <Autocomplete id="9" label="Small size with suggestion and header" size="small" withSuggestion withHeader/>

    <Autocomplete id="10" label="Small disabled"size="small" disabled />

  </div>
);

export default Overview;