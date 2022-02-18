import React, {FC} from "react";
import classNames from "classnames";

// TODO: remove this implementation when checkbox will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const setClasses = (disabled:boolean, error:boolean) => classNames(
  'form-control',
  {
    'form-control--disabled': disabled,
    'form-control--error': error
  });

const Checkbox: FC<CheckboxProps> = ({checked = false, disabled = false, error = false, indeterminate= false}) =>
    <label className={setClasses(disabled, error)}>
      <input
        type="checkbox"
        className="form-control__checkbox"
        disabled={disabled}
        defaultChecked={checked}
        ref={(input) => input ? input.indeterminate = indeterminate : null }/>
      Option
    </label>

export const CheckboxGroup: FC<CheckboxGroupProps> =
  ({
     disabled = false,
     error = false,
     hint = false,
     verticalLayout= false
  }) => (
  <div className="form-item">
    <label className="form-label" id="my-label-id">Label</label>
    <div className="form-item__wrapper">
      <div
        className={`form-control-group ${verticalLayout ? "form-control-group--column" : ""}`}
        role="group"
        aria-labelledby="my-label-id"
        aria-describedby={error ? "error-id" : hint ? "hint-id" : ""}
      >
        <Checkbox checked disabled={disabled} error={error} />
        <Checkbox disabled={disabled} error={error} />
        <Checkbox disabled={disabled} error={error} indeterminate/>
      </div>
      {error && <div className="form-item__error-message" id="error-id">Error message</div>}
      {hint && !error && <div className="form-item__hint" id="hint-id">Hint</div>}
    </div>
  </div>
)

interface CheckboxProps {
  checked?:boolean;
  disabled?: boolean;
  error?: boolean;
  indeterminate?:boolean;
}

interface CheckboxGroupProps extends CheckboxProps {
  verticalLayout?: boolean;
  hint?: boolean;
}

export default Checkbox;
