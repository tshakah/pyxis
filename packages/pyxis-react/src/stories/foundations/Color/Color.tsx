import React, { FC } from 'react';
import classNames from 'classnames';
import styles from './Color.module.scss';
import {ColorRowBackgroundType} from "./common";

const getClasses = (name: string, type: ColorRowBackgroundType): string => classNames(
  styles.item,
  {
    [`bg-${name}`]: type === 'solid',
    [`gradient-${name}`]: type === 'gradient',
  },
);

export const Color: FC<ColorProps> = ({ name, type = 'solid' }) => (
  <div className={getClasses(name, type)} />
);

interface ColorProps {
  name: string;
  type: ColorRowBackgroundType;
}

export default { Color };
