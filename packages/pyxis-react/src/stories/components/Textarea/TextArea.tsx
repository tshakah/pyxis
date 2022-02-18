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
  hint = false,
  id = "input-id",
  size = "large",
  value,
  withLabel= false,
}) => (
  <div className="form-item" style={{width: 320}}>
    {withLabel && <label className="form-label" htmlFor={id}>Label</label>}
    <div className="form-item__wrapper">
      <div className={getClasses(disabled, error)}>
        <textarea
          aria-describedby={error ? "errorMessage" : hint ? "hint" : undefined}
          className={`form-field__textarea ${size === "small" ? "form-field__textarea--small" : ""}`}
          disabled={disabled}
          id={id}
          placeholder="Textarea"
          value={value}
        />
      </div>
      {error && <div className="form-item__error-message" id="errorMessage">Error Message</div>}
      {hint && !error && <div className="form-item__hint" id="hint">Hint</div>}
    </div>
  </div>
);

export interface TextAreaProps {
  disabled?: boolean;
  error?: boolean;
  hint?: boolean;
  id?: string;
  size?: "large" | "small";
  value?: string;
  withLabel?: boolean;
}

export default TextArea;