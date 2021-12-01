import React, { FC } from 'react';

const Button:FC<ButtonProps> = ({ text }) => (
  <div className="text-l--bold bg-brand-base padding-s">
    {`Example ${text}`}
  </div>
);

export interface ButtonProps {
  text: string
}

export default Button;
