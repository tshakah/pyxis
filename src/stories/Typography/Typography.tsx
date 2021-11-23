import React, { FC } from 'react';
import classNames from 'classnames';
import { capitalize } from '../../utils';

const getClasses = (size: Size, weight: Weight, type: Type): string => classNames(
  {
    [`text-${size}--${weight}`]: type === 'text',
    [`title-${size}--${weight}`]: type === 'title',
  },
);

const Typography: FC<TypographyProps> = ({ size, weight, type }) => (
  <span className={getClasses(size, weight, type)}>
    {`${capitalize(type)} ${size.toUpperCase()}`}
  </span>
);

export default Typography;

interface TypographyProps {
  size: Size;
  weight: Weight;
  type: Type
}

export type Size = 's' | 'm' | 'l' | 'xl';
export type Weight = 'light' | 'book' | 'bold';
export type Type = 'text' | 'title';
