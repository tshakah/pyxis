import React, { FC } from 'react';
import classNames from 'classnames';

const getClasses = (size: string, className: string, isBoxed: boolean, alt:boolean): string => classNames(
  'icon',
  `icon--size-${size}`,
  className,
  { 'icon--boxed': isBoxed },
  { 'icon--alt': alt },
);

const Icon: FC<IconProps> = ({
  description, size = 'm', isBoxed = false, alt = false, children, className = '',
}) => (
  <div
    className={getClasses(size, className, isBoxed, alt)}
    role={description && 'img'}
    aria-label={description}
  >
    {children}
  </div>
);

export default Icon;

export interface IconProps extends CommonProps {
  description?: string,
  size?: 's' | 'm' | 'l',
  isBoxed?: boolean,
  alt?: boolean
}

interface CommonProps {
  className?: string,
}
