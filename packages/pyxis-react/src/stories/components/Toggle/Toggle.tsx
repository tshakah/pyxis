import {FC} from "react";
import classNames from "classnames";
import styles from "./Toggle.module.scss"

// TODO: remove this implementation when Toggle will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const Toggles = () =>
  <div className={styles.wrapper}>
    <Toggle label={false} />
    <Toggle checked />
    <Toggle disabled />
  </div>;

const getClasses = (disabled:boolean) => classNames(
  'toggle',
  {
    'toggle--disabled': disabled
  });

const Toggle:FC<ToggleProps> = ({disabled = false, checked = false, label=true}) => (
  <label className={getClasses(disabled)}>
    {label && "Label"}
    <input
      aria-label={label ? undefined : "description"}
      aria-checked={checked}
      type="checkbox"
      role="switch"
      className="toggle__input"
      disabled={disabled}
      defaultChecked={checked} />
  </label>
);

interface ToggleProps {
  disabled?:boolean;
  checked?:boolean;
  label?:boolean;
}

export default Toggles;
