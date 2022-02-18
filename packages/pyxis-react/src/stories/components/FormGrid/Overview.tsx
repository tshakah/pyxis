import React, {FC} from "react";
import Button from "components/Button";
import {
  IconAlert,
  IconCalendar,
  IconChevronLeft,
  IconExclamationCircle
} from "components/Icon/Icons";

// TODO: remove this implementation when grid will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.
const Overview: FC = () => (
  <form className="form">
    <fieldset>
      <div className="form-grid form-grid--gap-large">
        {/* Row con legend */}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <legend className="form-legend">
              <span className="form-legend__title">Scegli il sinistro da denunciare</span>
            </legend>
          </div>
        </div>
        <div className="form-grid__row form-grid__row--large">
          <div className="form-grid__row__column">
            <div className="form-item">
              <div className="form-item__wrapper form-item__wrapper--gap-large">
                <div className="form-card-group" role="radiogroup" aria-labelledby="my-label-id">
                  <label className="form-card form-card--large">
                    <span className="form-card__addon">
                      <img src="static/media/placeholder.7d73ad27.svg" width="70" height="70" alt=""/>
                    </span>
                    <span className="form-card__content-wrapper">
                      <span className="form-card__title">Veicoli</span>
                    </span>
                    <input type="radio" name="large" className="form-control__radio"/>
                  </label>
                  <label className="form-card form-card--large">
                    <span className="form-card__addon">
                      <img src="static/media/placeholder.7d73ad27.svg" width="70" height="70" alt=""/>
                    </span>
                    <span className="form-card__content-wrapper">
                      <span className="form-card__title">Casa e Famiglia</span>
                    </span>
                    <input type="radio" name="large" className="form-control__radio"/>
                  </label>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <div className="button-group" style={{justifyContent: "center"}}>
              <Button size="large">Procedi</Button>
            </div>
          </div>
        </div>
      </div>
    </fieldset>
    <fieldset>
      <div className="form-grid form-grid--gap-large">
        {/* Row con messaggio */}
        <div className="form-grid__row form-grid__row--large">
          <div className="form-grid__row__column">
            <div className="message message--alert message--with-background-color" role="status">
              <div className="message__icon">
                <IconAlert />
              </div>
              <div className="message__content-wrapper">
                <div className="message__text">
                  Per completare la denuncia di questo sinistro, è necessario rivolgersi anche alle compagnie degli altri veicoli coinvolti.
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Row con legend */}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <legend className="form-legend">
              <span className="form-legend__title">Inserisci alcune informazioni di base</span>
            </legend>
          </div>
        </div>

        {/* Container con field */}
        <div className="form-grid__row">
          <div className="form-grid">
            <div className="form-grid__row form-grid__row--small">
              <div className="form-grid__row__column">
                <div className="form-item">
                  <label className="form-label" htmlFor="targa">
                    Targa
                  </label>
                  <div className="form-item__wrapper">
                    <div className="form-field">
                      <label className="form-field__wrapper">
                        <input
                          type="text"
                          className="form-field__text"
                          id="targa"
                          placeholder="AA123BC"
                        />
                      </label>
                    </div>
                    <div className="form-item__hint">Suggerimento.</div>
                  </div>
                </div>
              </div>
              <div className="form-grid__row__column">
                <div className="form-item">
                  <label className="form-label" htmlFor="data-nascita">
                    Data di nascita
                  </label>
                  <div className="form-item__wrapper">
                    <div className="form-field form-field--with-prepend-icon">
                      <label className="form-field__wrapper">
                        <div className="form-field__addon">
                          <IconCalendar />
                        </div>
                        <input type="date" className="form-field__date" id="data-nascita" placeholder="Date field"/>
                      </label>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div className="form-grid__row form-grid__row--small">
              <div className="form-grid__row__column">
                <div className="form-item">
                  <label className="form-label" htmlFor="data-sinistro">
                    Data del sinistro
                  </label>
                  <div className="form-item__wrapper">
                    <div className="form-field form-field--with-prepend-icon">
                      <label className="form-field__wrapper">
                        <div className="form-field__addon">
                          <IconCalendar />
                        </div>
                        <input type="date" className="form-field__date" id="data-sinistro" placeholder="Date field"/>
                      </label>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Row con messaggio ghost */}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <div className="message message--ghost" role="status">
              <div className="message__icon">
                <IconExclamationCircle />
              </div>
              <div className="message__content-wrapper">
                <div className="message__text">
                  Se il veicolo non è assicurato con Prima, invia una mail a <a href="#" className="c-action-base">prima@prima.it</a>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Row con button group*/}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <div className="button-group space-between">
              <Button size="large" variant="ghost" icon={IconChevronLeft}>Indietro</Button>
              <Button size="large">Procedi</Button>
            </div>
          </div>
        </div>
      </div>
    </fieldset>
    <fieldset>
      <div className="form-grid form-grid--gap-large">
        {/* Row con legend */}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <legend className="form-legend">
              <span className="form-legend__title">Inserisci i dettagli del sinistro</span>
            </legend>
          </div>
        </div>

        {/* Container con field */}
        <div className="form-grid__row">
          <div className="form-grid">
            <div className="form-grid__row form-grid__row--small">
              <div className="form-grid__row__column">
                <div className="form-item">
                  <label className="form-label" id="pedoni-ciclisti-coinvolti">
                    Pedoni o ciclisti coinvolti
                  </label>
                  <div className="form-item__wrapper form-item__wrapper--gap-large">
                    <div className="form-card-group form-card-group--row" role="radiogroup" aria-labelledby="pedoni-ciclisti-coinvolti">
                      <label className="form-card form-card--error">
                      <span className="form-card__content-wrapper">
                        <span className="form-card__text">Si</span>
                      </span>
                        <input type="radio" name="default" className="form-control__radio"/>
                      </label>
                      <label className="form-card form-card--error">
                        <span className="form-card__content-wrapper">
                          <span className="form-card__text">No</span>
                        </span>
                        <input type="radio" name="default" className="form-control__radio"/>
                      </label>
                    </div>
                    <div className="form-item__error-message">Messaggio errore</div>
                  </div>
                </div>
              </div>
            </div>
            <div className="form-grid__row form-grid__row--small">
              <div className="form-grid__row__column">
                <div className="form-item">
                  <label className="form-label" htmlFor="label-and-text-area">Dinamica del sinistro</label>
                  <div className="form-item__wrapper">
                    <div className="form-field">
                      <textarea className="form-field__textarea"  id="label-and-text-area" placeholder="Descrivi la dinamica del sinistro" />
                    </div>
                    <div className="form-item__hint">Suggerimento.</div>
                  </div>
                  <div className="custom-html-element text-s-light">
                    Esempio: Il veicolo assicurato è uscito di strada e ha urtato un veicolo fermo a bordo strada.
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Row con button group*/}
        <div className="form-grid__row form-grid__row--small">
          <div className="form-grid__row__column">
            <div className="button-group space-between">
              <Button size="large" variant="ghost" icon={IconChevronLeft}>Indietro</Button>
              <Button size="large">Procedi</Button>
            </div>
          </div>
        </div>
      </div>
    </fieldset>
  </form>
)

export default Overview;