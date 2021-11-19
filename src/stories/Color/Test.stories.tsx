import React, { FC } from 'react';
import Color from './Color';
import {
  pyxisColors,
  generateTestComponentMeta, PyxisColor,
} from './common';
import '../pyxis.scss';
import Table, { TableRow } from '../components/Table';
import { pascalToKebab } from '../../utils';

export default generateTestComponentMeta();

const generateRow = ({ name, value }: PyxisColor): TableRow => [
  <Color name={pascalToKebab(name)} key={value} />,
  name,
];

export const Test: FC = () => (
  <Table
    head={['Sample', 'Key']}
    body={pyxisColors.map(generateRow)}
    gridTemplateColumns="100px"
  />
);
