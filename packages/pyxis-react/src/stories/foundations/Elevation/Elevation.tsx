import React, {FC} from 'react';
import classNames from 'classnames';
import styles from './Elevation.module.scss';
import {pascalToKebab} from 'commons/utils/string';

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

interface ElevationProps {
  size: ElevationSize,
  color: ElevationColor,
}

export default Elevation;
