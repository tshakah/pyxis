import React, {FC, useState} from "react";
import Button from "components/Button";
import {IconAlert, IconCalendar, IconChevronLeft, IconExclamationCircle} from "components/Icon/Icons";
import styles from "./Form.module.scss"
import classNames from "classnames";

const getFormClasses = (showGrid: boolean): string => classNames(
  {
    ['form-show-grid']: showGrid
  },
);

const Form: FC = () => {
  const [showGrid, setShowGrid] = useState(true);

  return (
    <div className={styles.wrapper}>
      <div className={styles.showGrid}>
        <label className="form-control">
          <input
            type="checkbox"
            className="form-control__checkbox"
            checked={showGrid}
            onClick={() => setShowGrid(!showGrid)}
          />
          Show Grid
        </label>
      </div>
      <div className={getFormClasses(showGrid)}>
        <form className="form">
        <fieldset className="form-fieldset">
          <div className="form-grid form-grid--gap-large">
            {/* Row with message */}
            <div className="form-grid__row form-grid__row--large">
              <div className="form-grid__row__column">
                <div className="message message--alert message--with-background-color" role="status">
                  <div className="message__icon">
                    <IconAlert />
                  </div>
                  <div className="message__content-wrapper">
                    <div className="message__text">
                      To complete the report of this accident, it is also necessary to contact the companies
                      of the other vehicles involved.
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Row with legend */}
            <div className="form-grid__row form-grid__row--small">
              <div className="form-grid__row__column">
                <legend className="form-legend">
                  <span className="form-legend__title">Basic information</span>
                </legend>
              </div>
            </div>

            {/* Row with sub-grid */}
            <div className="form-grid__row">
              <div className="form-grid">
                <div className="form-grid__row form-grid__row--small">
                  <div className="form-grid__row__column">
                    <div className="form-item">
                      <label className="form-label" htmlFor="form-name">
                        Name
                      </label>
                      <div className="form-item__wrapper">
                        <div className="form-field">
                          <label className="form-field__wrapper">
                            <input type="text" className="form-field__text" id="form-name" placeholder="John"/>
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="form-grid__row__column">
                    <div className="form-item">
                      <label className="form-label" htmlFor="form-surname">
                        Surname
                      </label>
                      <div className="form-item__wrapper">
                        <div className="form-field">
                          <label className="form-field__wrapper">
                            <input type="text" className="form-field__text" id="form-surname" placeholder="Doe"/>
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="form-grid__row form-grid__row--small">
                  <div className="form-grid__row__column">
                    <div className="form-item">
                      <label className="form-label" htmlFor="form-claim-date">
                        Date of claim
                      </label>
                      <div className="form-item__wrapper">
                        <div className="form-field form-field--with-prepend-icon">
                          <label className="form-field__wrapper">
                            <div className="form-field__addon">
                              <IconCalendar />
                            </div>
                            <input type="date" className="form-field__date" id="form-claim-date" placeholder="Date field"/>
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Row with ghost message */}
            <div className="form-grid__row form-grid__row--small">
              <div className="form-grid__row__column">
                <div className="message message--ghost" role="status">
                  <div className="message__icon">
                    <IconExclamationCircle />
                  </div>
                  <div className="message__content-wrapper">
                    <div className="message__text">
                      If the vehicle is not insured with Prima, send an email to <a href="#" className="c-action-base">hello@prima.it</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Row with button group */}
            <div className="form-grid__row form-grid__row--small">
              <div className="form-grid__row__column">
                <div className="button-group">
                  <Button size="large" variant="ghost" icon={IconChevronLeft}>Back</Button>
                  <Button size="large">Proceed</Button>
                </div>
              </div>
            </div>
          </div>
        </fieldset>
      </form>
      </div>
    </div>
  )
}

export default Form;