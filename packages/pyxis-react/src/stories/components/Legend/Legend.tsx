import React, {FC} from "react";
import {IconCar} from "components/Icon/Icons";
import placeholder from "stories/assets/placeholder.svg";
import CheckboxCard from "../CheckboxCard/CheckboxCard";

// TODO: remove this implementation when legend will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.
export const Legends = () =>
  <form className="form">
    <fieldset>
      <div className="form-grid">
        <div className="form-grid__row">
          <div className="form-grid__row__column">
            <Legend withIcon/>
          </div>
        </div>
      </div>
    </fieldset>
    <fieldset>
      <div className="form-grid">
        <div className="form-grid__row">
          <div className="form-grid__row__column">
            <Legend withImage/>
          </div>
        </div>
      </div>
    </fieldset>
    <fieldset>
      <div className="form-grid">
        <div className="form-grid__row">
          <div className="form-grid__row__column">
            <Legend/>
          </div>
        </div>
      </div>
    </fieldset>
    <fieldset>
      <div className="form-grid">
        <div className="form-grid__row">
          <div className="form-grid__row__column">
            <Legend alignLeft/>
          </div>
        </div>
      </div>
    </fieldset>
  </form>

const Legend:FC<LegendProps> =
  ({
     withDescription = true,
     withIcon = false,
     withImage = false,
     alignLeft = false
  }) =>
  <legend className={`form-legend ${alignLeft ? "form-legend--align-left" : ""}`}>
    {(withIcon || withImage) &&
      <span className="form-legend__addon">
        {withIcon && <IconCar boxedVariant="brand"/>}
        {withImage && <img src={placeholder} width={56} height={56} alt=""/>}
      </span>
    }
    <span className="form-legend__title">Legend title</span>
    {withDescription && <span className="form-legend__text">Legend description</span>}
  </legend>

interface LegendProps {
  alignLeft?: boolean;
  withDescription?: boolean;
  withIcon?: boolean;
  withImage?: boolean;
}

export default Legend;