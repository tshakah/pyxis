import React, {FC} from "react";
import "../Form.scss"

const TextArea: FC = () => (
  <>
    <div className="form-grid wrapper">
      <div className="form-item">
        <label className="label">Textarea</label>
        <div className="form-field">
          <textarea className="form-field__textarea" placeholder="Textarea" />
        </div>
      </div>
      <div className="form-item">
        <div className="form-item">
          <label className="label">Textarea small</label>
          <div className="form-field form-field--disabled">
            <textarea className="form-field__textarea" placeholder="Textarea small" disabled />
          </div>
        </div>
      </div>
      <div className="form-item">
        <label className="label">Textarea</label>
        <div className="form-field form-field--error">
          <textarea className="form-field__textarea " placeholder="Textarea" />
          <div className="form-field__error-message">Error message</div>
        </div>
      </div>
      <div className="form-item">
        <div className="form-item">
          <label className="label label--small">Textarea small</label>
          <div className="form-field">
            <textarea className="form-field__textarea form-field__textarea--small" placeholder="Textarea small" />
          </div>
        </div>
      </div>
    </div>
  </>
)

export default TextArea;