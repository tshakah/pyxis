import React, {FC} from "react";
import placeholder from "../placeholder.svg"
import "../Form.scss"

const CheckboxCard: FC = () => (
  <div className="form-grid wrapper wrapper--card">
    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card form-card--large">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>
        <label className="form-card form-card--large form-card--checked">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card checked</span>
            <span className="form-card__text">Text description checked</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked/>
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card form-card--large">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Only title</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card form-card--large form-card--checked">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__text">Only text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked/>
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card form-card--large form-card--error">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card error</span>
            <span className="form-card__text">Text description error</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" />
        </label>

        <label className="form-card form-card--large form-card--error form-card--checked">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card error checked</span>
            <span className="form-card__text">Text description error checked</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked/>
        </label>
        <div className="form-card-group__error-message">Error message</div>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card form-card--large form-card--disabled">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card disabled</span>
            <span className="form-card__text">Text description disabled</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" disabled/>
        </label>

        <label className="form-card form-card--large form-card--disabled form-card--checked">
          <span className="form-card__addon">
            <img src={placeholder} width={70} height={70} alt=""/>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card disabled checked</span>
            <span className="form-card__text">Text description disabled checked</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked disabled/>
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card">
          <span className="form-card__addon form-card__addon--with-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card form-card--checked">
          <span className="form-card__addon form-card__addon--with-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked />
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card">
          <span className="form-card__addon form-card__addon--with-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Only title</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card">
          <span className="form-card__addon form-card__addon--with-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__text">Only text</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" />
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card form-card--error">
          <span className="form-card__addon form-card__addon--with-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card form-card--disabled">
          <span className="form-card__addon form-card__addon--with-icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
              <path
                d="M12.025 23.848A11.848 11.848 0 1 1 23.873 12a11.861 11.861 0 0 1-11.848 11.848zm0-22.695A10.848 10.848 0 1 0 22.873 12 10.86 10.86 0 0 0 12.025 1.152zm0 12.712a.5.5 0 0 1-.5-.5V7.416a.5.5 0 0 1 1 0v5.949a.5.5 0 0 1-.5.5zm0 3.22a.5.5 0 0 1-.5-.5v-.711a.5.5 0 0 1 1 0v.711a.5.5 0 0 1-.5.5z"/>
            </svg>
          </span>
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" disabled/>
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <span className="form-card__addon">€ 1.000,00</span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>
        <label className="form-card form-card--checked">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <span className="form-card__addon">€ 1.000,00</span>
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked />
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Only title</span>
          </span>
          <span className="form-card__addon">€ 1.000,00</span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card">
          <span className="form-card__content-wrapper">
            <span className="form-card__text">Only text</span>
          </span>
          <span className="form-card__addon">€ 1.000,00</span>
          <input type="checkbox" name="default" className="form-control__checkbox" />
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card form-card--error">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <span className="form-card__addon">€ 1.000,00</span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card form-card--disabled">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <span className="form-card__addon">€ 1.000,00</span>
          <input type="checkbox" name="default" className="form-control__checkbox" disabled/>
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>
        <label className="form-card form-card--checked">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked />
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Only title</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card">
          <span className="form-card__content-wrapper">
            <span className="form-card__text">Only text</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" />
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-card-group">
        <label className="form-card form-card--error">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox"/>
        </label>

        <label className="form-card form-card--disabled">
          <span className="form-card__content-wrapper">
            <span className="form-card__title">Title card</span>
            <span className="form-card__text">Text description</span>
          </span>
          <input type="checkbox" name="default" className="form-control__checkbox" disabled/>
        </label>
      </div>
    </div>
  </div>
)

export default CheckboxCard;