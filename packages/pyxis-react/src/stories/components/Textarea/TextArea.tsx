import React, {FC} from "react";
import classNames from "classnames";

// TODO: remove this implementation when textarea will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const getClasses = (disabled: boolean, error: boolean): string => classNames(
  "form-field",
  {
    ["form-field--disabled"]: disabled,
    ["form-field--error"]: error,
  },
);

const TextArea: FC<TextAreaProps> = ({
  disabled = false,
  error = false,
  id = "",
  size = "large",
  value
}) => (
  <div className={getClasses(disabled, error)} style={{width: 320}}>
    <textarea
      aria-describedby={error ? "errorMessage" : undefined}
      className={`form-field__textarea ${size === "small" ? "form-field__textarea--small" : ""}`}
      disabled={disabled}
      id={id}
      placeholder="Textarea"
      value={value}
    />
    {error && <div className="form-field__error-message" id="errorMessage">Error Message</div>}
  </div>
);

export interface TextAreaProps {
  disabled?: boolean
  error?: boolean
  id?: string
  size?: "large" | "small";
  value?: string;
}

export default TextArea;