import React, {FC} from "react";
import classNames from "classnames";

// TODO: remove this implementation when radio will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const setClasses = (disabled:boolean, error:boolean):string => classNames(
  'form-control',
  {
    'form-control--disabled': disabled,
    'form-control--error': error
  })

const Radio: FC<RadioProps> = (
  {
    checked = false,
    disabled = false,
    error = false,
    name,
    onChange= () => {}
  }) =>
  <label className={setClasses(disabled, error)}>
    <input
      type="radio"
      name={name}
      className="form-control__radio"
      disabled={disabled}
      checked={checked}
      onChange={onChange}
    />
    Option
  </label>

export const RadioGroup: FC<RadioGroupProps> =
  ({name, disabled= false, error= false, hint = false, verticalLayout = false}) => {
  const [activeIndex, setActiveIndex] = React.useState(0);
  return (
    <div className="form-item">
      <label className="form-label" id="my-label-id">Label</label>
      <div className="form-item__wrapper">
        <div
          className={`form-control-group ${verticalLayout ? "form-control-group--column" : ""}`}
          role="radiogroup"
          aria-labelledby="my-label-id"
          aria-describedby={error ? "error-id" : hint ? "hint-id" : ""}
        >
          <Radio name={name} disabled={disabled} error={error} checked={activeIndex === 0}
                 onChange={() => setActiveIndex(0)}/>
          <Radio name={name} disabled={disabled} error={error} checked={activeIndex === 1}
                 onChange={() => setActiveIndex(1)}/>
        </div>
        {error && <div className="form-item__error-message" id="error-id">Error message</div>}
        {hint && !error && <div className="form-item__hint" id="hint-id">Hint</div>}
      </div>
    </div>
  )
}

interface RadioProps {
  checked?: boolean;
  disabled?: boolean;
  error?: boolean;
  name: string;
  onChange?: () => void;
}

interface RadioGroupProps extends RadioProps {
  verticalLayout?: boolean;
  hint?: boolean;
}

export default Radio;