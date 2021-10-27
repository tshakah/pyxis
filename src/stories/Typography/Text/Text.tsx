import React, { FC } from 'react';
import '../Typography.scss';

const Text: FC<TextProps> = ({ size, weight }) => (
  <span className={`text-${size}--${weight}`}>Lorem ipsum dolor sit amet.</span>
);

export default Text;

interface TextProps {
  size: TextSize,
  weight: TextWeight;
}

export type TextSize = 'l' | 'm' | 's';
export type TextWeight = 'light' | 'book' | 'bold';
