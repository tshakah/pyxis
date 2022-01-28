import React, {FC} from "react";
import classNames from "classnames";
import placeholder from "stories/assets/placeholder.svg"
import {IconPrimaLogo} from "components/Icon/Icons";

// TODO: remove this implementation when checkboxCard will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const setClasses = (isChecked: boolean, isLarge:boolean, error:boolean, disabled:boolean):string => classNames(
  "form-card",
  {
    "form-card--large": isLarge,
    "form-card--checked": isChecked,
    "form-card--error": error,
    "form-card--disabled": disabled
  }
)

const CheckboxCard: FC<CheckboxProps> =
  ({
     addon= false,
     checked = false,
     disabled = false,
     error = false,
     hasTitle = true,
     hasText = true,
     isLarge = false,
     priceAddon= false
   }) => {
    const [isChecked, setIsChecked] = React.useState(checked)
    return(
      <label className={setClasses(isChecked, isLarge, error, disabled)}>
        {isLarge && <span className="form-card__addon">
          <img src={placeholder} width={70} height={70} alt=""/>
        </span>}
        {addon && <span className="form-card__addon form-card__addon--with-icon">
          <IconPrimaLogo size={"l"}/>
        </span>}
        <span className="form-card__content-wrapper">
          {hasTitle && <span className="form-card__title">Title card</span>}
          {hasText && <span className="form-card__text">Text description</span>}
        </span>
        {priceAddon && <span className="form-card__addon">€ 1.000,00</span>}
        <input
          type="checkbox"
          name="default"
          className="form-control__checkbox"
          defaultChecked={isChecked}
          disabled={disabled}
          onChange={() => setIsChecked(!isChecked)}
        />
      </label>
    );
  }

export const CheckboxCardGroup: FC<CheckboxProps> =
  ({
     error= false,
     ...props
  }) => (
  <div className="form-item">
    <label className="form-label" id="my-label-id">Label</label>
    <div
      className="form-card-group"
      role="group"
      aria-labelledby="my-label-id"
      aria-describedby={error ? "error-id" : ""}
    >
      <CheckboxCard error={error} checked {...props}/>
      <CheckboxCard error={error} {...props} />
      {error && <div className="form-control-group__error-message" id="error-id">Error message</div>}
    </div>
  </div>
)

interface CheckboxProps {
  addon?: boolean;
  checked?: boolean;
  disabled?: boolean;
  error?: boolean;
  hasTitle?: boolean;
  hasText?: boolean;
  isLarge?: boolean;
  priceAddon?: boolean;
}

export default CheckboxCard;
