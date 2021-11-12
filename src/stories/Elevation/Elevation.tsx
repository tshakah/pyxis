import { FC } from 'react';
import classNames from 'classnames';
import styles from './Elevation.module.scss';

const getItemClasses = (size: string, color: string, opacity: string): string => classNames(
  styles.item,
  `elevation-${size}-${color}-${opacity}`,
  {
    [`gradient-${color}`]: opacity === '40',
  },
);
const Elevation: FC<ElevationProps> = ({ size, color }) => {
  const [colorName, opacity] = color.split('-');
  return (
    <div className={styles.row}>
      <div className={getItemClasses(size, colorName, opacity)} />
      <code>
        {`.elevation-${size}-${color}`}
      </code>
    </div>
  );
};

export default Elevation;

interface ElevationProps {
  size: ElevationSize,
  color: ElevationColor,
}

export type ElevationSize = 's' | 'm' | 'l';
export type ElevationColor =
  'action-15' | 'action-40' | 'brand-15' | 'brand-40' | 'neutral-15' | 'neutral-40';
