import React, { FC } from 'react';
import Color from './Color';
import { ColorRow, colors, generateTestComponentMeta } from './common';
import '../pyxis.scss';
import Table, { TableRow } from '../components/Table';
import { pascalToKebab } from '../../utils';

export default generateTestComponentMeta();

const generateRow = ({ name, value }: ColorRow): TableRow => [
  <Color name={pascalToKebab(name)} key={value} />,
  name,
];

export const Test: FC = () => (
  <Table
    head={['Sample', 'Key']}
    body={colors.map(generateRow)}
    gridTemplateColumns="100px"
  />
);
