import './Typography.scss';

import React from 'react';

interface TextProps {
    size: 'l' | 'm' | 's',
    weight: 'light' | 'book' | 'bold';
}

const Text = ({ size, weight }: TextProps) => <span className={`text-${size}--${weight}`}>Lorem ipsum dolor sit amet.</span>;

export default Text;
