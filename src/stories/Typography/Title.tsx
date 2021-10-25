import React from 'react';

interface TitleProps {
    size: 'xl' | 'l' | 'm' | 's',
    weight: 'book' | 'bold'
}

const Title = ({ size, weight }: TitleProps) => {
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
