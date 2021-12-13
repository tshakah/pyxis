import React, {FC} from 'react';
import classNames from 'classnames';
import styles from './Elevation.module.scss';
import {pascalToKebab} from 'utils';

const getItemClasses = (size: string, color: string, opacity: string): string => classNames(
  styles.item,
  `elevation-${size}-${color}-${opacity}`,
  {
    [`gradient-${color}`]: opacity === '40',
    [styles[`border-${color}`]]: opacity === '15',
  },
);
const Elevation: FC<ElevationProps> = ({ size, color }) => {
  const [colorName, opacity] = pascalToKebab(color).split('-');
  return (
    <div className={getItemClasses(size, colorName, opacity)} />
  );
};

export default Elevation;

interface ElevationProps {
  size: Size,
  color: Color,
}

export type Size = 's' | 'm' | 'l';
export type Color =
  'action15' | 'action40' | 'brand15' | 'brand40' | 'neutral15' | 'neutral40';
