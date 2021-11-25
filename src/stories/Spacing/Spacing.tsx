import React, { FC } from 'react';
import styles from './Spacing.module.scss';

const Spacing:FC<SpacingProps> = ({ size }) => (
  <div className={`${styles.spacing} ${styles[`space-${size}`]}`} />
);

export default Spacing;

export interface SpacingProps {
  size: Size
}

export type Size = 'xxxl' | 'xxl' | 'xl' | 'l' | 'm' | 's' | 'xs' | 'xxs' | 'xxxs';
