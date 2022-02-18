import React, {FC} from 'react';
import Table, {TableRow} from 'stories/utils/Table';
import {IconPrimaLogo} from 'components/Icon/Icons';
import {generateTestComponentMeta, SizeRow, sizes, variants} from './common';

export default generateTestComponentMeta();

const generateBody = ({ size }:SizeRow): TableRow => [
  size,
  <IconPrimaLogo size={size} key={size} />,
  variants.map(variant =>
    (<IconPrimaLogo size={size} boxedVariant={variant} key={`${size}_boxed_${variant}`} />)
  ),
  <div className="bg-neutral-base padding-3xs">
    <IconPrimaLogo size={size} key={`${size}_boxed_alt`} alt />
  </div>,
].flat();

export const Test: FC = () => (
  <Table
    head={['Size', 'Default', variants, 'Alt'].flat()}
    body={sizes.map(generateBody)}
  />
);
