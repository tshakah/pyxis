import {FC} from "react";
import classNames from "classnames";
import {pascalToKebab} from "commons/utils/string";
import "./Badge.scss";

const Badges = () => (
  <>
    <div className="badge-wrapper">
      <Badge />
      <Badge variant="brand" />
      <Badge variant="action" />
      <Badge variant="success" />
      <Badge variant="error" />
      <Badge variant="alert" />
      <Badge variant="neutralGradient" />
      <Badge variant="brandGradient" />
    </div>
    <div className="badge-wrapper bg-neutral-base">
      <Badge alt />
      <Badge variant="brand" alt />
      <Badge variant="action" alt />
      <Badge variant="success" alt />
      <Badge variant="error" alt />
      <Badge variant="alert" alt />
      <Badge alt ghost />
    </div>
  </>
);

const setClasses = (alt:boolean , ghost:boolean, variant?:string):string => classNames(
  "badge",
  {
    [`badge--${variant && pascalToKebab(variant)}`]: variant,
    "badge--alt": alt && !ghost,
    "badge--ghost": alt && ghost,
  }
);

const Badge:FC<BadgeProps> = ({alt= false, variant , ghost = false}) => (
  <span className={setClasses(alt, ghost, variant)}>Badge</span>
);

interface BadgeProps {
  alt?: boolean;
  variant?: "brand" | "action" | "error" | "success" | "alert" | "neutralGradient" | "brandGradient";
  ghost?: boolean;
}

export default Badges;