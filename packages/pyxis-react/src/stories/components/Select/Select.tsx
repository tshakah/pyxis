import React, {FC, useState} from "react";
import classNames from "classnames";
import {IconChevronDown} from "../../../components/Icon/Icons";

// TODO: remove this implementation when select will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const getClasses = (disabled: boolean, error: boolean, native: boolean, opened: boolean): string => classNames(
  "form-field",
  {
    ["form-field--disabled"]: disabled,
    ["form-field--error"]: error,
    ["form-field--with-dropdown"]: !native,
    ["form-field--with-opened-dropdown"]: opened && !disabled && !native,
  },
);

const getSelectClasses = (size: "large" | "small", active: boolean): string => classNames(
  "form-field__select",
  {
    ["form-field__select--filled"]: active,
    ["form-field__select--small"]: size === "small",
  },
);

const getDropdownClasses = (size: "large" | "small"): string => classNames(
  "form-field__dropdown-wrapper",
  {
    ["form-field__dropdown-wrapper--small"]: size === "small",
  },
);

const Select: FC<SelectProps> = ({
  disabled = false,
  error = false,
  filled = false,
  id = "",
  native = false,
  size = "large",
}) => {
  const [isOpened, setIsOpened] = useState(false);
  const [isActive, setIsActive] = useState(filled);

  const clickOnSelect = (event: any) => {
    setIsOpened(!isOpened);
    event.preventDefault();
    console.log(event)
  }

  const clickOnItem = () => {
    setIsActive(true);
    setIsOpened(false);
  }

  const onKeyDown = (event: React.KeyboardEvent) => {
    if(native) return;

    const openDropdown = () => {
      event.preventDefault();
      setIsOpened(true);
    }

    const closeDropdown = () => {
      setIsOpened(false);
    }

    switch (event.key) {
      case ' ': // Yes, the event.key name for "Space" is " ". Thank you JS.
      case 'ArrowUp':
      case 'ArrowDown':
        return openDropdown();
      case 'Escape':
      case 'Enter':
      case 'Tab':
        return closeDropdown();
      default:
        return null;
    }
  }

  return (
    <div className={getClasses(disabled, error, native, isOpened)} style={{width: 320}}>
      <label className="form-field__wrapper" onClick={clickOnSelect}>
        <select
          aria-describedby={error ? "errorMessage" : undefined}
          className={getSelectClasses(size, isActive)}
          disabled={disabled}
          id={id}
          onKeyDown={onKeyDown}
        >
          <option hidden disabled selected>Select something</option>
          <option value="1">Good vibes 1</option>
          <option value="2" selected={isActive}>Good vibes 2</option>
          <option value="3">Good vibes 3</option>
          <option value="4">Good vibes 4</option>
        </select>
        <div className="form-field__addon">
          <IconChevronDown />
        </div>
        {error && <div className="form-field__error-message" id="errorMessage">Error message</div>}
      </label>
      {!native && <div className={getDropdownClasses(size)} onClick={clickOnItem}>
        <div className="form-field__dropdown">
          <div className="form-field__dropdown__item">Good vibes 1</div>
          <div className={`form-field__dropdown__item ${isActive ? "form-field__dropdown__item--active": ""}`} onClick={clickOnItem}>Good vibes 2</div>
          <div className="form-field__dropdown__item">Good vibes 3</div>
          <div className="form-field__dropdown__item">Good vibes 4</div>
        </div>
      </div>}
    </div>
  )
};

interface SelectProps {
  disabled?: boolean,
  error?: boolean,
  filled?: boolean,
  id?: string,
  native?: boolean,
  size?: "large" | "small";
}

export default Select;