import React, {FC} from "react";
import classNames from "classnames";
import {pascalToKebab} from "commons/utils/string";

// TODO: remove this implementation when Badge will be implemented in pyxis-react
// Non-exhaustive implementation, made for testing purposes only.

export const badges = (alt?:boolean) => (
  <>
    <Badge />
    <Badge variant="brand" text="Brand" alt={alt} />
    <Badge variant="action" text="Action" alt={alt} />
    <Badge variant="success" text="Success" alt={alt} />
    <Badge variant="error" text="Error" alt={alt} />
    <Badge variant="alert" text="Alert" alt={alt} />
    { alt ?
      <Badge alt ghost text="Ghost"/> :
      <>
        <Badge variant="neutralGradient" text="Neutral Gradient"/>
        <Badge variant="brandGradient" text="Brand Gradient" />
      </>
    }
  </>
);

const getClasses = (alt:boolean , ghost:boolean, variant?:string):string => classNames(
  "badge",
  {
    [`badge--${variant && pascalToKebab(variant)}`]: variant,
    "badge--alt": alt && !ghost,
    "badge--ghost": alt && ghost,
  }
);

const Badge:FC<BadgeProps> = ({alt= false, variant , ghost = false, text= "Badge"}) => (
  <span className={getClasses(alt, ghost, variant)}>{text}</span>
);

interface BadgeProps {
  alt?: boolean;
  variant?: "brand" | "action" | "error" | "success" | "alert" | "neutralGradient" | "brandGradient";
  ghost?: boolean;
  text?: string;
}

export default Badge;