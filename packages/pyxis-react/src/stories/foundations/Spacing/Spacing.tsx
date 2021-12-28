import React, {FC} from 'react';
import styles from './Spacing.module.scss';

export const Spacing:FC<SpacingProps> = ({ size }) => (
  <div className={`${styles.spacing} ${styles[`padding-h-${size}`]}`} />
);

export interface SpacingProps {
  size: Spacing
}

export default { Spacing };

