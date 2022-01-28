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
  <div className="form-control-group">
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
  </div>

export const RadioGroup: FC<RadioProps> =
  ({name, disabled= false, error= false}) => {
  const [activeIndex, setActiveIndex] = React.useState(0);
  return (
    <div className="form-item">
      <label className="form-label" id="my-label-id">Label</label>
      <div
        className="form-control-group"
        role="radiogroup"
        aria-labelledby="my-label-id"
        aria-describedby={error ? "error-id" : ""}
      >
        <Radio name={name} disabled={disabled} error={error} checked={activeIndex === 0}
               onChange={() => setActiveIndex(0)}/>
        <Radio name={name} disabled={disabled} error={error} checked={activeIndex === 1}
               onChange={() => setActiveIndex(1)}/>
        {error && <div className="form-control-group__error-message" id="error-id">Error message</div>}
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

export default Radio;