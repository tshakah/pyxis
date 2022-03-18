import React, {FC, useState} from "react";
import classNames from "classnames";
import {IconClose, IconMapMarker, IconSearch} from "components/Icon/Icons";
import Button from "components/Button";
import shortid from "shortid";

// TODO: remove this implementation when autocomplete will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

const getClasses = (disabled: boolean, error: boolean, opened: boolean): string => classNames(
  "form-field",
  {
    ["form-field--disabled"]: disabled,
    ["form-field--error"]: error,
    ["form-field--with-opened-dropdown"]: opened && !disabled,
  },
);

const getAutocompleteClasses = (size: "medium" | "small", active: boolean): string => classNames(
  "form-field__autocomplete",
  {
    ["form-field__autocomplete--filled"]: active,
    ["form-field__autocomplete--small"]: size === "small",
  },
);

const getResetClasses = (size: "medium" | "small"): string => classNames(
  "form-field__addon__reset",
  {
    ["form-field__addon__reset--small"]: size === "small",
  },
);

const getDropdownWrapperClasses = (size: "medium" | "small"): string => classNames(
  "form-dropdown-wrapper",
  {
    ["form-dropdown-wrapper--small"]: size === "small",
  },
);

const getDropdownClasses = (withHeader: boolean): string => classNames(
  "form-dropdown",
  {
    ["form-dropdown--with-header"]: withHeader
  },
);

const choices:string[] = [
  "Italy",
  "Netherlands",
  "Poland",
  "Spain",
  "United Kingdom"
]

const AutocompleteItem: FC<AutocompleteItemProps> = ({value, onClick}) =>
  <div className="form-dropdown__item" onClick={() => onClick(value)}>
    {value}
  </div>


const Autocomplete: FC<AutocompleteProps> = ({
  disabled = false,
  error = false,
  hint = false,
  id,
  label = undefined,
  name,
  size = "medium",
  withHeader = false,
  withSuggestion = false,
}) => {
  const [isOpened, setIsOpened] = useState(false);
  const [isFilled, setIsFilled] = useState(false);
  const [filter, setFilter] = useState<string | null>(null);
  const [value, setValue] = useState<string | null>(null);

  const clickOnItem = (item: string) => {
    setValue(item);
    setIsFilled(true);
    setFilter(item)
    setIsOpened(false);
  }

  const clickOnReset = (event: React.MouseEvent<HTMLButtonElement>) => {
    setValue(null);
    setIsFilled(false);
    setFilter(null);
    event.preventDefault();
  }

  const onChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setValue(event.target.value)
    setFilter(event.target.value || null)
    setIsFilled(!!event.target.value)
    event.preventDefault();
  }

  const filteredChoices = choices.filter((item: string) =>
    filter ? item.toLowerCase().includes(filter.toLowerCase()) : item,
  );

  return (
    <div className="form-item" style={{width: 320}}>
      {label && <label className="form-label" htmlFor={id}>{label}</label>}
      <div className="form-item__wrapper">
        <div className={getClasses(disabled, error, isOpened)}>
          <label className="form-field__wrapper">
            <input
              aria-autocomplete="both"
              aria-describedby={error ? "errorMessage" : hint ? "hint" : undefined}
              aria-expanded={isOpened}
              aria-owns={`${id}-dropdown-list`}
              autoComplete="off"
              className={getAutocompleteClasses(size, isFilled)}
              disabled={disabled}
              id={id}
              onChange={(e) => onChange(e)}
              onFocus={(e) => e.preventDefault()}
              onClick={() => setIsOpened(!isOpened)}
              placeholder="Search"
              name={name}
              role="combobox"
              type="text"
              value={value || ''}
            />
            <div className="form-field__addon">
              {!isFilled && <IconSearch />}
              {isFilled &&
                <button className={getResetClasses(size)} onClick={(e) => clickOnReset(e)}>
                  <IconClose size="s" description="Reset field"/>
                </button>
              }
            </div>
          </label>
          <div className={getDropdownWrapperClasses(size)}>
            <div
              className={getDropdownClasses(withHeader)}
              id={`${id}-dropdown-list`}
              role="listbox"
            >
              {withSuggestion && filter === null &&
                <div className="form-dropdown__suggestion">
                  <div className="form-dropdown__suggestion__icon">
                    <IconMapMarker />
                  </div>
                  <div className="form-dropdown__suggestion__wrapper">
                    <div className="form-dropdown__suggestion__title">
                      Suggestion title
                    </div>
                    <div className="form-dropdown__suggestion__subtitle">
                      Subtitle text goes on this line
                    </div>
                  </div>
                </div>
              }
              {(
                (withHeader && withSuggestion && filter && filteredChoices.length > 0)
                || (withHeader && !withSuggestion && filteredChoices.length > 0)
                ) &&
                <div className="form-dropdown__header">
                  Select an item:
                </div>
              }
              {((withSuggestion && !!filter) || !withSuggestion) && filteredChoices.map(item =>
                <AutocompleteItem
                  key={item}
                  onClick={() => clickOnItem(item)}
                  value={item}
                />
              )}
              {filteredChoices.length === 0 &&
                <div className="form-dropdown__no-results">
                  No results found.
                  <div className="form-dropdown__no-results__action">
                    <Button variant="ghost" size="medium">
                      Action link
                    </Button>
                  </div>
                </div>
              }
            </div>
          </div>
        </div>
        {error && <div className="form-item__error-message" id="errorMessage">Error message</div>}
        {hint && !error && <div className="form-item__hint" id="hint">Hint</div>}
      </div>
    </div>
  )
};

interface AutocompleteProps {
  defaultValue?: string,
  disabled?: boolean,
  error?: boolean,
  filled?: boolean,
  hint?: boolean,
  id?: string,
  label?: string,
  name?: string,
  size?: "medium" | "small";
  withHeader?: boolean,
  withSuggestion?: boolean,
}

interface AutocompleteItemProps {
  value: string;
  onClick: (item: string) => void;
}

export default Autocomplete;