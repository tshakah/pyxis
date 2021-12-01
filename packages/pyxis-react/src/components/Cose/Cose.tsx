import React, { FC } from 'react';

const Cose:FC<CoseProps> = ({ text }) => (
  <div className="text-s--bold bg-action-base padding-s c-neutral-light">
    {`Example ${text}`}
  </div>
);

export interface CoseProps {
  text: string
}

export default Cose;
