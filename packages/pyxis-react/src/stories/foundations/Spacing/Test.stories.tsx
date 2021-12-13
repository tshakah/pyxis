import React, {FC} from 'react';
import {generateTestComponentMeta, spacing, SpacingRow} from './common';
import Table, {TableRow} from 'stories/utils/Table';
import Spacing from './Spacing';

export default generateTestComponentMeta();

const generateRow = ({ size }: SpacingRow): TableRow => [
  <Spacing size={size} key={size} />,
  size,
];

export const Test: FC = () => (
  <Table
    head={['Sample', 'Key']}
    body={spacing.map(generateRow)}
    gridTemplateColumns="120px"
  />
);
