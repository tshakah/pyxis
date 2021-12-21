import React, {FC} from 'react';
import Table, {TableRow} from 'stories/utils/Table';
import {IconPrimaLogo} from 'components/Icon/Icons';
import {generateTestComponentMeta, SizeRow, sizes} from './common';

export default generateTestComponentMeta();

const generateBody = ({ size }:SizeRow): TableRow => [
  size,
  <IconPrimaLogo size={size} key={size} />,
  <IconPrimaLogo size={size} key={`${size}_boxed`} isBoxed />,
  <div className="bg-neutral-base padding-3xs">
    <IconPrimaLogo size={size} key={`${size}_boxed_alt`} isBoxed alt />
  </div>,
];

export const Test: FC = () => (
  <Table
    head={['Size', 'Default', 'Boxed', 'Alt']}
    body={sizes.map(generateBody)}
  />
);
