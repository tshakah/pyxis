import React, {FC} from 'react';
import { Color } from './Color';
import {ColorRow, generateTestComponentMeta, gradients, colors} from './common';
import 'stories/pyxis.scss';
import Table, {TableRow} from 'stories/utils/Table';
import {pascalToKebab} from 'commons/utils/string';

export default generateTestComponentMeta();

const generateRow = ({name, value, type}: ColorRow): TableRow => [
  <Color name={pascalToKebab(name)} key={value} type={type}/>,
  name,
];

export const Test: FC = () => (
  <Table
    head={['Sample', 'Key']}
    body={[...colors, ...gradients].map(generateRow)}
    gridTemplateColumns="100px"
  />
);
