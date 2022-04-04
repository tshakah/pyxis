import React, { FC } from 'react';
import classNames from 'classnames';
import { IconProps } from './types';

const getClasses = (size: string, className: string, alt:boolean, boxedVariant?: string): string => classNames(
  'icon',
  `icon--size-${size}`,
  className,
  { 'icon--boxed': boxedVariant || alt },
  { 'icon--alt': alt },
  { [`icon--${boxedVariant}`]: boxedVariant },
);

const Icon: FC<IconProps> = ({
  alt = false,
  className = '',
  description,
  boxedVariant,
  size = 'm',
  children,
}) => (
  <div
    aria-hidden={!description}
    aria-label={description}
    className={getClasses(size, className, alt, boxedVariant)}
    role={description && 'img'}
  >
    {children}
  </div>
);

export default Icon;
