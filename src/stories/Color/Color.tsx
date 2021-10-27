import React, { FC } from 'react';
import './Color.scss';

const Color: FC<ColorProps> = ({ name }) => (
  <div className={`storybook-color bg-${name}`}>{name}</div>
);

export default Color;

export type PyxisColor =
  | 'action-base'
  | 'action-dark'
  | 'action-light'
  | 'alert-base'
  | 'alert-dark'
  | 'alert-light'
  | 'brand-base'
  | 'brand-dark'
  | 'brand-light'
  | 'error-base'
  | 'error-dark'
  | 'error-light'
  | 'neutral-25'
  | 'neutral-50'
  | 'neutral-75'
  | 'neutral-85'
  | 'neutral-95'
  | 'neutral-base'
  | 'neutral-light'
  | 'success-base'
  | 'success-dark'
  | 'success-light';

interface ColorProps {
  name: PyxisColor;
}
