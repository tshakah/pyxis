import React, {FC} from "react";
import "../Form.scss"

const DateField: FC = () => (
  <div>
      <div className="form-grid wrapper">
        <div className="form-item">
          <label className="form-label">Input date</label>
          <div className="form-field form-field--with-append-icon">
            <label className="form-field__wrapper">
              <div className="form-field__addon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                  <path
                    d="M20.054 5.011h-.116V4.34a1.851 1.851 0 1 0-3.701 0v.671H7.778V4.34a1.851 1.851 0 1 0-3.701 0v.671h-.131a2.503 2.503 0 0 0-2.5 2.5v11.5a2.503 2.503 0 0 0 2.5 2.5h16.108a2.503 2.503 0 0 0 2.5-2.5v-11.5a2.503 2.503 0 0 0-2.5-2.5zm-2.817-.671a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zm-12.16 0a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zM3.946 6.011h.173a1.849 1.849 0 0 0 3.617 0h8.543a1.849 1.849 0 0 0 3.617 0h.158a1.502 1.502 0 0 1 1.5 1.5v1.05H2.446v-1.05a1.502 1.502 0 0 1 1.5-1.5zm16.108 14.5H3.946a1.502 1.502 0 0 1-1.5-1.5v-9.45h19.108v9.451a1.502 1.502 0 0 1-1.5 1.5zM7.395 12.444H4.41a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.985a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1zm-12.11 3.517H4.41a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.985a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1z"/>
                </svg>
              </div>
              <input type="date" className="form-field__date"/>
            </label>
          </div>
        </div>

        <div className="form-item">
          <label className="form-label">Input date filled</label>
          <div className="form-field form-field--with-append-icon">
            <label className="form-field__wrapper">
              <div className="form-field__addon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                  <path
                    d="M20.054 5.011h-.116V4.34a1.851 1.851 0 1 0-3.701 0v.671H7.778V4.34a1.851 1.851 0 1 0-3.701 0v.671h-.131a2.503 2.503 0 0 0-2.5 2.5v11.5a2.503 2.503 0 0 0 2.5 2.5h16.108a2.503 2.503 0 0 0 2.5-2.5v-11.5a2.503 2.503 0 0 0-2.5-2.5zm-2.817-.671a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zm-12.16 0a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zM3.946 6.011h.173a1.849 1.849 0 0 0 3.617 0h8.543a1.849 1.849 0 0 0 3.617 0h.158a1.502 1.502 0 0 1 1.5 1.5v1.05H2.446v-1.05a1.502 1.502 0 0 1 1.5-1.5zm16.108 14.5H3.946a1.502 1.502 0 0 1-1.5-1.5v-9.45h19.108v9.451a1.502 1.502 0 0 1-1.5 1.5zM7.395 12.444H4.41a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.985a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1zm-12.11 3.517H4.41a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.985a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1z"/>
                </svg>
              </div>
              <input type="date" className="form-field__date form-field__date--filled" value={'2000-12-21'}/>
            </label>
          </div>
        </div>

        <div className="form-item">
          <label className="form-label">Input date</label>
          <div className="form-field form-field--with-append-icon form-field--error">
            <label className="form-field__wrapper">
              <div className="form-field__addon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                  <path
                    d="M20.054 5.011h-.116V4.34a1.851 1.851 0 1 0-3.701 0v.671H7.778V4.34a1.851 1.851 0 1 0-3.701 0v.671h-.131a2.503 2.503 0 0 0-2.5 2.5v11.5a2.503 2.503 0 0 0 2.5 2.5h16.108a2.503 2.503 0 0 0 2.5-2.5v-11.5a2.503 2.503 0 0 0-2.5-2.5zm-2.817-.671a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zm-12.16 0a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zM3.946 6.011h.173a1.849 1.849 0 0 0 3.617 0h8.543a1.849 1.849 0 0 0 3.617 0h.158a1.502 1.502 0 0 1 1.5 1.5v1.05H2.446v-1.05a1.502 1.502 0 0 1 1.5-1.5zm16.108 14.5H3.946a1.502 1.502 0 0 1-1.5-1.5v-9.45h19.108v9.451a1.502 1.502 0 0 1-1.5 1.5zM7.395 12.444H4.41a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.985a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1zm-12.11 3.517H4.41a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.985a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1z"/>
                </svg>
              </div>
              <input type="date" className="form-field__date"/>
            </label>
            <div className="form-field__error-message">Error message</div>
          </div>
        </div>

        <div className="form-item">
          <label className="form-label">Input date</label>
          <div className="form-field form-field--with-append-icon form-field--disabled">
            <label className="form-field__wrapper">
              <div className="form-field__addon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                  <path
                    d="M20.054 5.011h-.116V4.34a1.851 1.851 0 1 0-3.701 0v.671H7.778V4.34a1.851 1.851 0 1 0-3.701 0v.671h-.131a2.503 2.503 0 0 0-2.5 2.5v11.5a2.503 2.503 0 0 0 2.5 2.5h16.108a2.503 2.503 0 0 0 2.5-2.5v-11.5a2.503 2.503 0 0 0-2.5-2.5zm-2.817-.671a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zm-12.16 0a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zM3.946 6.011h.173a1.849 1.849 0 0 0 3.617 0h8.543a1.849 1.849 0 0 0 3.617 0h.158a1.502 1.502 0 0 1 1.5 1.5v1.05H2.446v-1.05a1.502 1.502 0 0 1 1.5-1.5zm16.108 14.5H3.946a1.502 1.502 0 0 1-1.5-1.5v-9.45h19.108v9.451a1.502 1.502 0 0 1-1.5 1.5zM7.395 12.444H4.41a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.985a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1zm-12.11 3.517H4.41a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.985a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1z"/>
                </svg>
              </div>
              <input type="date" className="form-field__date" disabled/>
            </label>
          </div>
        </div>

        <div className="form-item">
          <label className="form-label form-label--small">Input date small</label>
          <div className="form-field form-field--with-append-icon">
            <label className="form-field__wrapper">
              <div className="form-field__addon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={20} height={20}>
                  <path
                    d="M20.054 5.011h-.116V4.34a1.851 1.851 0 1 0-3.701 0v.671H7.778V4.34a1.851 1.851 0 1 0-3.701 0v.671h-.131a2.503 2.503 0 0 0-2.5 2.5v11.5a2.503 2.503 0 0 0 2.5 2.5h16.108a2.503 2.503 0 0 0 2.5-2.5v-11.5a2.503 2.503 0 0 0-2.5-2.5zm-2.817-.671a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zm-12.16 0a.851.851 0 1 1 1.701 0v1.285a.851.851 0 1 1-1.701 0zM3.946 6.011h.173a1.849 1.849 0 0 0 3.617 0h8.543a1.849 1.849 0 0 0 3.617 0h.158a1.502 1.502 0 0 1 1.5 1.5v1.05H2.446v-1.05a1.502 1.502 0 0 1 1.5-1.5zm16.108 14.5H3.946a1.502 1.502 0 0 1-1.5-1.5v-9.45h19.108v9.451a1.502 1.502 0 0 1-1.5 1.5zM7.395 12.444H4.41a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.985a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1zm-12.11 3.517H4.41a.5.5 0 0 0 0 1h2.985a.5.5 0 0 0 0-1zm6.055 0h-2.985a.5.5 0 1 0 0 1h2.985a.5.5 0 1 0 0-1zm6.055 0h-2.986a.5.5 0 0 0 0 1h2.986a.5.5 0 0 0 0-1z"/>
                </svg>
              </div>
              <input type="date" className="form-field__date form-field__date--small"/>
            </label>
          </div>
        </div>
      </div>
    </div>
)

export default DateField;