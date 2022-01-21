import React, {FC} from "react";
import "../Form.scss"

const Radio: FC = () => (
  <div className="form-grid wrapper">
      <div className="form-item">
        <label className="form-label">Label</label>
        <div className="form-control-group">
          <label className="form-control">
            <input type="radio" name="default" className="form-control__radio"/>
            Radio
          </label>
          <label className="form-control">
            <input type="radio" name="default" className="form-control__radio" defaultChecked/>
            Radio
          </label>
        </div>
      </div>

    <div className="form-item">
      <label className="form-label">Label disabled</label>
      <div className="form-control-group">
        <label className="form-control form-control--disabled">
          <input type="radio" name="disabled" className="form-control__radio" disabled/>
          Radio
        </label>
        <label className="form-control form-control--disabled">
          <input type="radio" name="disabled" className="form-control__radio" defaultChecked disabled/>
          Radio
        </label>
      </div>
    </div>
    <div className="form-item">
      <label className="form-label">Label error</label>
      <div className="form-control-group">
        <label className="form-control form-control--error">
          <input type="radio" name="error" className="form-control__radio"/>
          Radio
        </label>
        <label className="form-control form-control--error">
          <input type="radio" name="error" className="form-control__radio" defaultChecked/>
          Radio
        </label>
        <div className="form-control-group__error-message">Error message</div>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-control-group form-control-group--column">
        <label className="form-control form-control--error">
          <input type="radio" name="vertical" className="form-control__radio"/>
          Radio
        </label>
        <label className="form-control form-control--error">
          <input type="radio" name="vertical" className="form-control__radio" defaultChecked/>
          Radio
        </label>
        <div className="form-control-group__error-message">Error message</div>
      </div>
    </div>
  </div>
)

export default Radio;