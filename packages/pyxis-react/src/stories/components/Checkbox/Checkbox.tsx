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
  <div className="form-control-group">
    <label className={setClasses(disabled, error)}>
      <input
        type="checkbox"
        className="form-control__checkbox"
        disabled={disabled}
        defaultChecked={checked}
        ref={(input) => input ? input.indeterminate = indeterminate : null }/>
      Option
    </label>
  </div>

export const CheckboxGroup: FC<CheckboxProps> = ({disabled = false, error = false}) => (
  <div className="form-item">
    <label className="form-label" id="my-label-id">Label</label>
    <div
      className="form-control-group"
      role="group"
      aria-labelledby="my-label-id"
      aria-describedby={error ? "error-id" : ""}
    >
      <Checkbox checked disabled={disabled} error={error} />
      <Checkbox disabled={disabled} error={error} />
      <Checkbox disabled={disabled} error={error} indeterminate/>
      {error && <div className="form-control-group__error-message" id="error-id">Error message</div>}
    </div>
  </div>
)

interface CheckboxProps {
  checked?:boolean;
  disabled?: boolean;
  error?: boolean;
  indeterminate?:boolean;
}

export default Checkbox;
