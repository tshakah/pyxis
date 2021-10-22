import './Color.scss';

import React from 'react';

type PyxisColor =
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
  | 'neutral25'
  | 'neutral50'
  | 'neutral75'
  | 'neutral85'
  | 'neutral95'
  | 'neutral-base'
  | 'neutral-light'
  | 'success-base'
  | 'success-dark'
  | 'success-light';

interface ColorProps {
  name: PyxisColor;
}

const Color = ({ name }: ColorProps) => <div className={`storybook-color bg-${name}`}>{name}</div>;

export default Color;
