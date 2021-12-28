import React, {FC} from 'react';
import styles from './Radius.module.scss';

const Radius: FC<RadiusProps> = ({ size }) => (
  <div className={`${styles.radius} radius-${size}`} />
);

interface RadiusProps {
  size: RadiusSize
}

export default Radius;