import React, { FC } from 'react';
import './Spacing.scss';
import { pascalToKebab, repeat } from 'utils';

const Spacing: FC<SpacingProps> = ({ size, spacingType }) => {
  if (spacingType.startsWith('Padding')) {
    return (
      <div className={`wrapper ${pascalToKebab(spacingType)}-${size}`}>
        <span className="content">
          {`${pascalToKebab(spacingType)}-${size}`}
        </span>
      </div>
    );
  }

  if (spacingType.startsWith('Spacing')) {
    return (
      <div className={`wrapper ${spacingType.endsWith('V') ? 'is-vertical' : 'is-horizontal'}`}>
        {repeat((
          <span className={`content ${pascalToKebab(spacingType)}-${size}`}>
            {`${pascalToKebab(spacingType)}-${size}`}
          </span>),
        3)}
      </div>
    );
  }

  return (
    <div className={`${pascalToKebab(spacingType)}-${size} wrapper is-grid`}>
      {repeat((
        <span className="content">
          {`${pascalToKebab(spacingType)}-${size}`}
        </span>
      ),
      3)}
    </div>
  );
};

export default React.memo(Spacing);

export interface SpacingProps {
  size: SpacingSize
  spacingType: SpacingType
}

export type SpacingSize = 'xxxl' | 'xxl' | 'xl' | 'l' | 'm' | 's' | 'xs' | 'xxs' | 'xxxs';
export type SpacingType =
  'Padding'
  | 'PaddingH'
  | 'PaddingV'
  | 'SpacingV'
  | 'SpacingH'
  | 'RowGap'
  | 'ColumnGap';
