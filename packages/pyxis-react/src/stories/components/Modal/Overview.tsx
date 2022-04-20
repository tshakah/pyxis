import React, {FC, useEffect, useState} from "react";
import classNames from "classnames";
import Button from "components/Button";
import {IconCar, IconClose} from "components/Icon/Icons";
import Badge from "../Badge/Badge";

const getClasses = (show: boolean): string => classNames(
  "modal-backdrop",
  {
    ["modal-backdrop--show"]: show,
  },
);

const Overview: FC = () => {
  const [isOpened, setIsOpened] = useState(false);

  useEffect(() => {
    isOpened
      ? document.documentElement.classList.add('scroll-locked')
      : document.documentElement.classList.remove('scroll-locked');
  }, [isOpened])

  return (
    <>
      <Button size="large" onClick={() => setIsOpened(true)} style={{marginBottom: "200vh"}}>Open Modal</Button>
      <div
        aria-describedby='modal-description'
        aria-hidden={!isOpened}
        aria-modal={true}
        aria-labelledby='modal-label'
        className={getClasses(isOpened)}
        role="dialog"
      >
        <div id="modal-description" className="screen-reader-only">Accessibility description</div>
        <div className="modal-close" onClick={() => setIsOpened(false)}/>
        <div className="modal modal--large">
          <header className="modal__header">
            <div className="modal__header__wrapper">
              <div className="modal__header__badge">
                <Badge variant="brand">Badge</Badge>
              </div>
              <IconCar className="c-brand-base" size="l" />
              <h3 className="modal__header__title" id="modal-label">Come recuperare i MQ commerciali</h3>
            </div>
            <Button icon={IconClose} iconPlacement="only" variant="tertiary" size="medium" onClick={() => setIsOpened(false)}>Close</Button>
          </header>
          <div className="modal__content">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus.
          </div>
          <footer className="modal__footer">
            <div className="modal__footer__buttons modal__footer__buttons--full-width">
              <Button size="large">Button footer</Button>
            </div>
          </footer>
        </div>
      </div>
    </>
  )
}

export default Overview;
