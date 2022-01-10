import React, { FC } from 'react';
import classNames from 'classnames';
import { IconProps } from './types';

const getClasses = (size: string, className: string, boxed: boolean, alt:boolean): string => classNames(
  'icon',
  `icon--size-${size}`,
  className,
  { 'icon--boxed': boxed },
  { 'icon--alt': alt },
);

const Icon: FC<IconProps> = ({
  alt = false,
  className = '',
  description,
  boxed = false,
  size = 'm',
  children,
}) => (
  <div
    className={getClasses(size, className, boxed, alt)}
    role={description && 'img'}
    aria-label={description}
    aria-hidden={!description}
  >
    {children}
  </div>
);

export default Icon;
