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
  id = "",
  size = "large",
  value
}) => {
  const [isFilled, setIsFilled] = useState(!!value);

  return(
    <div className={getClasses(disabled, error)} style={{width: 320}}>
      <label className="form-field__wrapper">
        <div className="form-field__addon">
          <IconCalendar />
        </div>
        <input
          aria-describedby={error ? "errorMessage" : undefined}
          className={getInputClasses(size, isFilled)}
          disabled={disabled}
          id={id}
          onChange={(e) => setIsFilled(!!e.target.value)}
          placeholder="Date field"
          type="date"
          value={value}
        />
      </label>
      {error && <div className="form-field__error-message" id="errorMessage">Error Message</div>}
    </div>
  );
}

export interface DateFieldProps {
  disabled?: boolean
  error?: boolean
  id?: string
  size?: "large" | "small";
  value?: string;
}

export default DateField;