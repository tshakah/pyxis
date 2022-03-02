import {FC} from "react";
import classNames from "classnames";
import styles from "./Loader.module.scss"
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

export const Loaders:FC = () => (
  <>
    <div className={styles.wrapper}>
      <Loader type="spinner" />
      <Loader type="spinner" size="small" hasText />
      <Loader type="spinner" hasText/>
      <Loader type="car" />
      <Loader type="car" hasText />
    </div>
    <div className={`bg-neutral-base ${styles.wrapper}`}>
      <Loader type="spinner" alt />
      <Loader type="spinner" alt hasText />
      <Loader type="car" alt />
      <Loader type="car" hasText alt/>
    </div>
  </>
);

interface LoaderProps {
  alt?: boolean;
  hasText?: boolean;
  size?: 'medium' | 'small';
  type: 'spinner' | 'car';
}

export default Loader;
