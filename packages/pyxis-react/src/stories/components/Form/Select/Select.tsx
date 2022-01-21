import React, {FC, useState} from "react";
import "../Form.scss"

interface SelectProps {
  id: string,
  native?: boolean,
  small?: boolean,
  error?: boolean,
  disabled?: boolean
}

const Select: FC<SelectProps> = ({
  id,
  native = false,
  small = false,
  error = false,
  disabled = false
}) => {
  // TODO: remove this implementation when select will be implemented in pyxis-react
  // Non-exhaustive implementation, made for testing purposes only.
  const [isOpened, setIsOpened] = useState(false);
  const [isActive, setIsActive] = useState(false);

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
    <div
      className={`form-field
        ${!native ? "form-field--with-dropdown" : ""}
        ${error ? "form-field--error" : ""}
        ${disabled ? "form-field--disabled" : ""}
        ${isOpened && !disabled && !native ? "form-field--with-opened-dropdown" : ""}
      `}
    >
      <label className="form-field__wrapper" onClick={clickOnSelect}>
        <select
          className={`form-field__select
            ${isActive ? "form-field__select--filled" : ""}
            ${small ? "form-field__select--small" : ""}
          `}
          id={id}
          onKeyDown={onKeyDown}
          disabled={disabled}
        >
          <option hidden disabled selected>Select something</option>
          <option value="1">Good vibes 1</option>
          <option value="2" selected={isActive}>Good vibes 2</option>
          <option value="3">Good vibes 3</option>
          <option value="4">Good vibes 4</option>
        </select>
        <div className="form-field__addon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
            <path d="M17.8398 9.14342C18.0467 9.34101 18.0542 9.66889 17.8566 9.87576L12.422 15.5653C12.3248 15.667 12.1904 15.7248 12.0497 15.7254C11.909 15.7261 11.7741 15.6694 11.676 15.5685L6.14653 9.87898C5.94715 9.67384 5.95183 9.34591 6.15697 9.14653C6.36212 8.94715 6.69005 8.95183 6.88943 9.15697L12.0443 14.4609L17.1075 9.1602C17.3051 8.95334 17.6329 8.94582 17.8398 9.14342Z" />
          </svg>
        </div>
        {error && <div className="form-field__error-message">Error message</div>}
      </label>
      {!native && <div
        className={`form-field__dropdown-wrapper
          ${small ? "form-field__dropdown-wrapper--small" : ""}
        `}
        onClick={clickOnItem}
      >
        <div className="form-field__dropdown">
          <div className="form-field__dropdown__item">Good vibes 1</div>
          <div className={`form-field__dropdown__item ${isActive ? "form-field__dropdown__item--active": ""}`} onClick={clickOnItem}>Good vibes 2</div>
          <div className="form-field__dropdown__item">Good vibes 3</div>
          <div className="form-field__dropdown__item">Good vibes 4</div>
        </div>
      </div>}
    </div>
  )
}

const SelectGrid: FC = () => {
  return (
    <div className="form-grid wrapper">
      <div className="form-item">
        <label className="form-label" htmlFor="select-1">Default</label>
        <Select id="select-1" />
      </div>
      <div className="form-item">
        <label className="form-label" htmlFor="select-2">Small</label>
        <Select id="select-2" small/>
      </div>
      <div className="form-item">
        <label className="form-label" htmlFor="select-3">Disabled</label>
        <Select id="select-3" disabled/>
      </div>
      <div className="form-item">
        <label className="form-label" htmlFor="select-4">Disabled Small</label>
        <Select id="select-4" small disabled/>
      </div>
      <div className="form-item">
        <label className="form-label" htmlFor="select-5">Error</label>
        <Select id="select-5" error/>
      </div>
      <div className="form-item">
        <label className="form-label" htmlFor="select-6">Error Small</label>
        <Select id="select-6" small error/>
      </div>
      <div className="form-item">
        <label className="form-label" htmlFor="select-7">Native</label>
        <Select id="select-7" native/>
      </div>
      <div className="form-item">
        <label className="form-label" htmlFor="select-8">Native Small</label>
        <Select id="select-8" small native/>
      </div>
    </div>
  )
}

export default SelectGrid;