import React, { FC } from 'react';
import { IconProps } from 'components/Icon';

export const getAddonStringType = (addon:AddonType):AddonStringType => {
  if (addon && typeof addon === 'string') return 'text';
  return 'icon';
};

const Addon: FC<AddonProps> = ({ addon, id }) => (
  <div
    className="form-field__addon"
    data-testid={id}
    id={id}
  >
    {typeof addon === 'string' ? addon : addon({})}
  </div>
);

export default Addon;

export type AddonType = FC<IconProps> | string;
export type AddonStringType = 'icon' | 'text';

interface AddonProps {
  addon: AddonType;
  id: string;
}
