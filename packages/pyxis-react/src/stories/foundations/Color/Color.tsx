import React, { FC } from 'react';
import classNames from 'classnames';
import styles from './Color.module.scss';

const getClasses = (name: string, type: BackgroundColor): string => classNames(
  styles.item,
  {
    [`bg-${name}`]: type === 'solid',
    [`gradient-${name}`]: type === 'gradient',
  },
);

const Color: FC<ColorProps> = ({ name, type = 'solid' }) => (
  <div className={getClasses(name, type)} />
);

export default Color;

interface ColorProps {
  name: string;
  type?: BackgroundColor;
}

export type BackgroundColor = 'solid' | 'gradient';
