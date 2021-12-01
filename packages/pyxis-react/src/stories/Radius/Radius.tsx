import React, { FC } from 'react';
import styles from './Radius.module.scss';

const Radius: FC<RadiusProps> = ({ size }) => (
  <div className={`${styles.radius} radius-${size}`} />
);

export default Radius;

interface RadiusProps {
  size: Size
}

export type Size = 'xl' | 'l' | 'm' | 's' | 'xs';
