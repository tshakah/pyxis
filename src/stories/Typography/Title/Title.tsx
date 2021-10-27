import React, { FC } from 'react';

const Title: FC<TitleProps> = ({ size, weight }) => {
  const className = `title-${size}--${weight}`;

  switch (size) {
    case 'xl':
      return <h1 className={className}>Heading 1</h1>;
    case 'l':
      return <h2 className={className}>Heading 2</h2>;
    case 'm':
      return <h3 className={className}>Heading 3</h3>;
    case 's':
    default:
      return <h4 className={className}>Heading 4</h4>;
  }
};

export default Title;

interface TitleProps {
  size: TitleSize,
  weight: TitleWeight,
}

export type TitleSize = 'xl' | 'l' | 'm' | 's';
export type TitleWeight = 'book' | 'bold';
