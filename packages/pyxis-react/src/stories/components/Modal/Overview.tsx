import React, {FC, useState} from "react";
import classNames from "classnames";
import Badge from "stories/components/Badge/Badge";
import Button from "components/Button";
import {IconClose} from "components/Icon/Icons";

const getClasses = (centered: boolean): string => classNames(
  "modal",
  "modal--small",
  {
    ["modal--center"]: centered,
  },
);

const Overview: FC = () => {
  const [isOpened, setIsOpened] = useState(false);
  const [isCenter, setIsCenter] = useState(false);

  return (
    <>
      <div className="modal-backdrop">
        <div className={getClasses(isCenter)}>
          <header className="modal__header">
            <div className="modal__header__wrapper">
              <Badge variant="brand">Badge</Badge>
              <h3 className="modal__header__title">Come recuperare i MQ commerciali</h3>
            </div>
            <Button icon={IconClose} iconPlacement="only" variant="tertiary" size="medium">Close</Button>
          </header>
          <div className="modal__content">
            <div className="button-row">
              <Button onClick={() => setIsOpened(!isOpened)}>
                {isOpened ? "hide content" : "show content"}
              </Button>
              <Button onClick={() => setIsCenter(!isCenter)}>
                {isCenter ? "on top" : "on center"}
              </Button>
            </div>
            {isOpened &&
              <div className="modal-custom-content">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus.
              </div>
            }
          </div>
          <footer className="modal__footer">
            <Button>Button footer</Button>
          </footer>
        </div>
      </div>
    </>
  )
}

export default Overview;