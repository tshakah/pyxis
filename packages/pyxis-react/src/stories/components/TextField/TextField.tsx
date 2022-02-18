import React, {FC} from "react";
import classNames from "classnames";
import {IconProps} from "components/Icon";

// TODO: remove this implementation when text field will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const getClasses = (disabled: boolean, error: boolean, addonPlacement: "prepend" | "append", Icon?: FC<IconProps>, addonText?: string): string => classNames(
  "form-field",
  {
    ["form-field--disabled"]: disabled,
    ["form-field--error"]: error,
    ["form-field--with-prepend-text"]: addonText && addonPlacement === "prepend",
    ["form-field--with-append-text"]: addonText && addonPlacement === "append",
    ["form-field--with-prepend-icon"]: Icon && addonPlacement === "prepend",
    ["form-field--with-append-icon"]: Icon && addonPlacement === "append",
  },
);

const TextField: FC<TextFieldProps> = ({
  addonIcon: Icon,
  addonPlacement = "prepend",
  addonText,
  disabled = false,
  error = false,
  hint= false,
  id = "input-id",
  size = "large",
  value,
  withLabel= false
}) => (
  <div className="form-item" style={{width: 320}}>
    {withLabel && <label htmlFor={id} className="form-label">Label</label>}
    <div className="form-item__wrapper">
      <div className={getClasses(disabled, error, addonPlacement, Icon, addonText)}>
        <label className="form-field__wrapper">
          {(addonText || Icon) && addonPlacement === "prepend" && <div className="form-field__addon">
            {addonText && addonText}
            {Icon && <Icon />}
          </div>}
          <input
            aria-describedby={error ? "errorMessage" : hint ? "hint" : undefined}
            className={`form-field__text ${size === "small" ? "form-field__text--small" : ""}`}
            disabled={disabled}
            id={id}
            placeholder="Text field"
            type="text"
            value={value}
          />
          {(addonText || Icon) && addonPlacement === "append" && <div className="form-field__addon">
            {addonText && addonText}
            {Icon && <Icon />}
          </div>}
        </label>
      </div>
      {error && <div className="form-item__error-message" id="errorMessage">Error Message</div>}
      {hint && !error && <div className="form-item__hint" id="hint">Hint</div>}
    </div>
  </div>
);

export interface TextFieldProps {
  addonIcon?: FC<IconProps>;
  addonPlacement?: "prepend" | "append";
  addonText?: string;
  disabled?: boolean
  error?: boolean
  hint?: boolean
  id?: string;
  size?: "large" | "small";
  value?: string;
  withLabel?: boolean;
}

export default TextField;