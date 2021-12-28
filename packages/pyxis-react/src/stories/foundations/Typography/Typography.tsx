import React, {FC} from 'react';
import classNames from 'classnames';
import {capitalize} from 'commons/utils/string';
import {TypographySize, TypographyType, TypographyWeight} from "./common";

const getClasses = (size: TypographySize, weight: TypographyWeight, type: TypographyType): string => classNames(
  {
    [`text-${size}-${weight}`]: type === 'text',
    [`title-${size}-${weight}`]: type === 'title',
  },
);

const Typography: FC<TypographyProps> = ({ size, weight, type }) => (
  <span className={getClasses(size, weight, type)}>
    {`${capitalize(type)} ${size.toUpperCase()}`}
  </span>
);

interface TypographyProps {
  size: TypographySize;
  weight: TypographyWeight;
  type: TypographyType
}

export default Typography;