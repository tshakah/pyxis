import {FC} from "react";
import classNames from "classnames";
import {ReactComponent as LoaderCar} from "./LoaderCar.svg"

const getClasses = (size: "small" | "medium", alt:boolean, type: "car" | "spinner") => classNames(
  "loader",
  {
    "loader--small": size === "small",
    "loader--with-car": type === "car",
    "loader--alt": alt,
  }
)

const Loader:FC<LoaderProps> = ({alt= false, hasText= false, size= 'medium', type}) => (
  <div
    className={getClasses(size, alt, type)}
    role="status"
    aria-label="Loading..."
  >
    <div className={`loader__${type}`}>
      {type === "car" && <LoaderCar />}
    </div>
    {hasText && <div className="loader__text">Loader message...</div>}
  </div>
)

interface LoaderProps {
  alt?: boolean;
  hasText?: boolean;
  size?: 'medium' | 'small';
  type: 'spinner' | 'car';
}

export default Loader;
