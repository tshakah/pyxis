import React, {FC, useState} from "react";
import classNames from "classnames";
import {IconCalendar} from "components/Icon/Icons";

// TODO: remove this implementation when date field will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const getClasses = (disabled: boolean, error: boolean): string => classNames(
  "form-field",
  "form-field--with-prepend-icon",
  {
    ["form-field--disabled"]: disabled,
    ["form-field--error"]: error,
  },
);

const getInputClasses = (size: "large" | "small", filled: boolean): string => classNames(
  "form-field__date",
  {
    ["form-field__date--small"]: size === "small",
    ["form-field__date--filled"]: filled,
  },
);

const DateField: FC<DateFieldProps> = ({
  disabled = false,
  error = false,
  hint= false,
  id = "id",
  size = "large",
  value,
  withLabel= false,
}) => {
  const [isFilled, setIsFilled] = useState(!!value);

  return(
    <div className="form-item" style={{width: 320}}>
      {withLabel && <label className="form-label" htmlFor={id} >Label</label>}
      <div className="form-item__wrapper">
        <div className={getClasses(disabled, error)}>
          <label className="form-field__wrapper">
            <div className="form-field__addon">
              <IconCalendar />
            </div>
            <input
              aria-describedby={error ? "errorMessage" : hint ? "hint" : undefined}
              className={getInputClasses(size, isFilled)}
              disabled={disabled}
              id={id}
              onChange={(e) => setIsFilled(!!e.target.value)}
              placeholder="Date field"
              type="date"
              value={value}
            />
          </label>
        </div>
        {error && <div className="form-item__error-message" id="errorMessage">Error Message</div>}
        {hint && !error && <div className="form-item__hint" id="hint">Hint Message</div>}
      </div>
    </div>
  );
}

export interface DateFieldProps {
  disabled?: boolean
  error?: boolean
  hint?: boolean;
  id?: string;
  size?: "large" | "small";
  value?: string;
  withLabel?: boolean;
}

export default DateField;