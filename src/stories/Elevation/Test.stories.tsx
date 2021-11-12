import React, { FC } from 'react';
import Elevation from './Elevation';
import {
  elevationColors,
  elevationSizes,
  generateTestComponentMeta,
} from './common';
import '../pyxis.scss';
import styles from './Elevation.module.scss';

export default generateTestComponentMeta();

export const Test: FC = () => (
  <div className={`row-gap-xxxl padding-l ${styles.grid}`}>
    {elevationColors.map(
      (color) => (
        elevationSizes.map(
          (size) => <Elevation key={color + size} size={size} color={color} />,
        )
      ),
    )}
  </div>
);
