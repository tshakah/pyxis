import React, {FC} from "react";
import "../Form.scss"

const Checkbox: FC = () => (
  <div className="form-grid wrapper">
    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-control-group">
        <label className="form-control">
          <input type="checkbox" name="default" className="form-control__checkbox"/>
          Checkbox
        </label>
        <label className="form-control">
          <input type="checkbox" name="default" className="form-control__checkbox" defaultChecked/>
          Checkbox
        </label>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label disabled</label>
      <div className="form-control-group">
        <label className="form-control form-control--disabled">
          <input type="checkbox" name="disabled" className="form-control__checkbox" disabled/>
          Checkbox
        </label>
        <label className="form-control form-control--disabled">
          <input type="checkbox" name="disabled" className="form-control__checkbox" defaultChecked disabled/>
          Checkbox
        </label>
      </div>
    </div>
    <div className="form-item">
      <label className="form-label">Label error</label>
      <div className="form-control-group">
        <label className="form-control form-control--error">
          <input type="checkbox" name="error" className="form-control__checkbox"/>
          Checkbox
        </label>
        <label className="form-control form-control--error">
          <input type="checkbox" name="error" className="form-control__checkbox" defaultChecked/>
          Checkbox
        </label>
        <div className="form-control-group__error-message">Error message</div>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-control-group form-control-group--column">
        <label className="form-control form-control--error">
          <input type="checkbox" name="vertical" className="form-control__checkbox"/>
          Checkbox
        </label>
        <label className="form-control form-control--error">
          <input type="checkbox" name="vertical" className="form-control__checkbox" defaultChecked/>
          Checkbox
        </label>
        <div className="form-control-group__error-message">Error message</div>
      </div>
    </div>

    <div className="form-item">
      <label className="form-label">Label</label>
      <div className="form-control-group form-control-group--column">
        <label className="form-control">
          <input
            type="checkbox"
            name="indeterminate"
            className="form-control__checkbox"
            ref={(input) => input ? input.indeterminate = true : null }
          />
          Checkbox
        </label>
        <label className="form-control form-control--error">
          <input
            type="checkbox"
            name="indeterminate"
            className="form-control__checkbox"
            ref={(input) => input ? input.indeterminate = true : null }
          />
          Checkbox
        </label>
        <label className="form-control form-control--disabled">
          <input
            type="checkbox"
            name="indeterminate"
            className="form-control__checkbox"
            ref={(input) => input ? input.indeterminate = true : null }
            disabled
          />
          Checkbox
        </label>
      </div>
    </div>
  </div>
)

export default Checkbox;