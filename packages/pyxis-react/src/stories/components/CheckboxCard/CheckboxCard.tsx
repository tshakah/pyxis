import React, {FC} from "react";
import classNames from "classnames";
import placeholder from "stories/assets/placeholder.svg"
import {IconPrimaLogo} from "components/Icon/Icons";

// TODO: remove this implementation when checkboxCard will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const getClasses = (isChecked: boolean, isLarge:boolean, error:boolean, disabled:boolean):string => classNames(
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
     hasText = true,
     hasTitle = true,
     isLarge = false,
     priceAddon = false
   }) => {
    const [isChecked, setIsChecked] = React.useState(checked)
    return(
      <label className={getClasses(isChecked, isLarge, error, disabled)}>
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

const getGroupClasses = (layout: LayoutOptions | null):string => classNames(
  "form-card-group",
  {
    "form-card-group--row": layout === 'horizontal',
    "form-card-group--column": layout === 'vertical',
  }
)

export const CheckboxCardGroup: FC<CheckboxGroupProps> =
  ({
     error= false,
     hint= false,
     layout = null,
     ...props
  }) => (
  <div className="form-item">
    <label className="form-label" id="my-label-id">Label</label>
    <div className="form-item__wrapper form-item__wrapper--gap-large">
      <div
        className={getGroupClasses(layout)}
        role="group"
        aria-labelledby="my-label-id"
        aria-describedby={error ? "error-id" : hint ? "hint-id" : ""}
      >
        <CheckboxCard error={error} checked {...props}/>
        <CheckboxCard error={error} {...props} />
      </div>
      {error && <div className="form-item__error-message" id="error-id">Error message</div>}
      {hint && !error && <div className="form-item__hint" id="hint-id">Hint message</div>}
    </div>
  </div>
)

type LayoutOptions = "horizontal" | "vertical";

interface CheckboxProps {
  addon?: boolean;
  checked?: boolean;
  disabled?: boolean;
  error?: boolean;
  hasText?: boolean;
  hasTitle?: boolean;
  isLarge?: boolean;
  priceAddon?: boolean;
}

interface CheckboxGroupProps extends CheckboxProps {
  layout?: LayoutOptions | null;
  hint?: boolean;
}

export default CheckboxCard;
