import React, {FC} from "react";

// TODO: remove this implementation when grid will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.
const Overview: FC = () => (
  <form className="form">
    <fieldset>
      <div className="form-grid">
        {/* Field */}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <div className="form-item">
              <label className="form-label" id="pedoni-ciclisti-coinvolti">
                Pedoni o ciclisti coinvolti
              </label>
              <div className="form-item__wrapper">
                <div className="form-field">
                  <label className="form-field__wrapper">
                    <input
                      type="text"
                      aria-describedby="hint"
                      className="form-field__text"
                      id="id"
                      placeholder="Text field"
                    />
                  </label>
                </div>
                <div className="form-item__hint" id="hint">Hint</div>
              </div>
            </div>
          </div>
        </div>
        {/* Control group */}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <div className="form-item">
              <label className="form-label" id="pedoni-ciclisti-coinvolti">
                Pedoni o ciclisti coinvolti
              </label>
              <div className="form-item__wrapper">
                <div
                  className="form-control-group"
                  role="radiogroup"
                  aria-labelledby="my-label-id"
                  aria-describedby="error-id"
                >
                  <label className="form-control form-control--error">
                    <input type="radio" name="error" className="form-control__radio" checked/>
                    Sì
                  </label>
                  <label className="form-control form-control--error">
                    <input type="radio" name="error" className="form-control__radio"/>
                    No
                  </label>
                </div>
                <div className="form-item__error-message" id="error-id">Error message</div>
              </div>
            </div>
          </div>
        </div>
        {/* Card */}
        <div className="form-grid__row form-grid__row--large">
          <div className="form-grid__row__column">
            <div className="form-item">
              <label className="form-label" id="pedoni-ciclisti-coinvolti">
                Pedoni o ciclisti coinvolti
              </label>
              <div className="form-item__wrapper form-item__wrapper--gap-large">
                <div
                  className="form-card-group"
                  role="radiogroup"
                  aria-labelledby="my-label-id"
                  aria-describedby="error-id"
                >
                  <label className="form-card form-card--checked form-card--error">
                    <span className="form-card__content-wrapper">
                      <span className="form-card__title">Title card</span>
                      <span className="form-card__text">Text description</span>
                    </span>
                    <input type="radio" name="error" className="form-control__radio" checked/>
                  </label>
                  <label className="form-card form-card--error">
                    <span className="form-card__content-wrapper">
                      <span className="form-card__title">Title card</span>
                      <span className="form-card__text">Text description</span>
                    </span>
                    <input type="radio" name="error" className="form-control__radio"/>
                  </label>
                </div>
                <div className="form-item__error-message" id="error-id">Error message</div>
              </div>
            </div>
          </div>
        </div>
        {/* Textarea */}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <div className="form-item">
              <label className="form-label">
                Descrivi dinamica dell'incidente
              </label>
              <div className="form-item__wrapper">
                <div className="form-field">
                  <textarea
                    aria-describedby="hint"
                    className="form-field__textarea"
                    placeholder="Dinamica"
                  />
                </div>
                <div className="form-item__hint" id="hint">Massimo 300 caratteri</div>
              </div>
              <div className="custom-html-element text-s-light">
                Esempio: Il veicolo assicurato è uscito di strada e ha urtato un veicolo fermo a bordo strada.
              </div>
            </div>
          </div>
        </div>
      </div>
    </fieldset>
  </form>
)

export default Overview;