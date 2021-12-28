import React, {FC} from 'react';
import {generateTestComponentMeta, radius, RadiusRow} from './common';
import 'stories/pyxis.scss';
import Table, {TableRow} from 'stories/utils/Table';
import Radius from './Radius';

export default generateTestComponentMeta();

const generateRow = ({ size }: RadiusRow): TableRow => [
  <Radius size={size} key={size} />,
  size,
];

export const Test: FC = () => (
  <Table
    head={['Sample', 'Key']}
    body={radius.map(generateRow)}
    gridTemplateColumns="100px"
  />
);
