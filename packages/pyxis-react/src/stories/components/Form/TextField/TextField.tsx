import React, {FC} from "react";
import "../Form.scss"

const TextField: FC = () => (
  <>
    <div className="form-grid wrapper">
      <div className="form-item">
        <label className="form-label">Label</label>
        <div className="form-field">
          <input type="text" className="form-field__text" placeholder="Text field"/>
        </div>
      </div>
      <div className="form-item">
        <label className="label">Label</label>
        <div className="form-field form-field--with-leading-text">
          <label className="form-field__wrapper">
            <div className="form-field__addon">
              €
            </div>
            <input type="text" className="form-field__text" placeholder="Text field"/>
          </label>
        </div>
      </div>
      <div className="form-item">
        <label className="label">Label</label>
        <div className="form-field form-field--with-leading-icon">
          <label className="form-field__wrapper">
            <div className="form-field__addon">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                <path
                  d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
              </svg>
            </div>
            <input type="text" className="form-field__text" placeholder="Text field"/>
          </label>
        </div>
      </div>
    </div>

    {/* Only input */}
    <div className="wrapper">
      <div className="form-field">
        <input type="text" className="form-field__text" placeholder="Text field"/>
      </div>
      <div className="form-field">
        <input type="text" className="form-field__text" placeholder="Text field" value="Valid value"/>
      </div>
      <div className="form-field form-field--error">
        <input type="text" className="form-field__text" placeholder="Text field" value="Invalid value"/>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled">
        <input type="text" className="form-field__text" placeholder="Text field" disabled/>
      </div>
    </div>

    {/* Only input small */}
    <div className="wrapper">
      <div className="form-field">
        <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
      </div>
      <div className="form-field">
        <input type="text" className="form-field__text form-field__text--small" placeholder="Text field" value="Valid value"/>
      </div>
      <div className="form-field form-field--error">
        <input type="text" className="form-field__text form-field__text--small" placeholder="Text field" value="Invalid value"/>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled">
        <input type="text" className="form-field__text form-field__text--small" placeholder="Text field" disabled/>
      </div>
    </div>

    {/* Leading icon */}
    <div className="wrapper">
      <div className="form-field form-field--with-leading-icon">
        <label className="form-field__wrapper">
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
          <input type="text" className="form-field__text" placeholder="Text field"/>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-leading-icon">
        <label className="form-field__wrapper">
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
          <input type="text" className="form-field__text" placeholder="Text field"/>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-leading-icon">
        <label className="form-field__wrapper">
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
          <input type="text" className="form-field__text" placeholder="Text field" disabled/>
        </label>
      </div>
    </div>

    {/* Trailing icon */}
    <div className="wrapper">
      <div className="form-field form-field--with-trailing-icon">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text" placeholder="Text field"/>
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-trailing-icon">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text" placeholder="Text field"/>
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-trailing-icon">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text" placeholder="Text field"/>
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
        </label>
      </div>
    </div>

    {/* Leading icon small */}
    <div className="wrapper">
      <div className="form-field form-field--with-leading-icon">
        <label className="form-field__wrapper">
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={20} height={20}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-leading-icon">
        <label className="form-field__wrapper">
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={20} height={20}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-leading-icon">
        <label className="form-field__wrapper">
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={20} height={20}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field" disabled/>
        </label>
      </div>
    </div>

    {/* Trailing icon small */}
    <div className="wrapper">
      <div className="form-field form-field--with-trailing-icon">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={20} height={20}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-trailing-icon">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={20} height={20}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-trailing-icon">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
          <div className="form-field__addon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={20} height={20}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </div>
        </label>
      </div>
    </div>

    {/* Leading text */}
    <div className="wrapper">
      <div className="form-field form-field--with-leading-text">
        <label className="form-field__wrapper">
          <span className="form-field__addon">text addon</span>
          <input type="text" className="form-field__text" placeholder="Text field"/>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-leading-text">
        <label className="form-field__wrapper">
          <span className="form-field__addon">text addon</span>
          <input type="text" className="form-field__text" placeholder="Text field"/>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-leading-text">
        <label className="form-field__wrapper">
          <span className="form-field__addon">text addon</span>
          <input type="text" className="form-field__text" placeholder="Text field" disabled/>
        </label>
      </div>
    </div>

    {/* Trailing text */}
    <div className="wrapper">
      <div className="form-field form-field--with-trailing-text">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text" placeholder="Text field"/>
          <span className="form-field__addon">text addon</span>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-trailing-text">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text" placeholder="Text field"/>
          <span className="form-field__addon">text addon</span>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-trailing-text">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text" placeholder="Text field" disabled/>
          <span className="form-field__addon">text addon</span>
        </label>
      </div>
    </div>

    {/* Leading text small */}
    <div className="wrapper">
      <div className="form-field form-field--with-leading-text">
        <label className="form-field__wrapper">
          <span className="form-field__addon">text addon</span>
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-leading-text">
        <label className="form-field__wrapper">
          <span className="form-field__addon">text addon</span>
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-leading-text">
        <label className="form-field__wrapper">
          <span className="form-field__addon">text addon</span>
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field" disabled/>
        </label>
      </div>
    </div>

    {/* Trailing text small */}
    <div className="wrapper">
      <div className="form-field form-field--with-trailing-text">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
          <span className="form-field__addon">text addon</span>
        </label>
      </div>
      <div className="form-field form-field--error form-field--with-trailing-text">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field"/>
          <span className="form-field__addon">text addon</span>
        </label>
        <div className="form-field__error-message">Error message</div>
      </div>
      <div className="form-field form-field--disabled form-field--with-trailing-text">
        <label className="form-field__wrapper">
          <input type="text" className="form-field__text form-field__text--small" placeholder="Text field" disabled/>
          <span className="form-field__addon">text addon</span>
        </label>
      </div>
    </div>
  </>
)

export default TextField;