import React, { FC } from 'react';
import {
  generateTestComponentMeta, pyxisText, pyxisTitle, PyxisTypography,
} from './common';
import Table, { TableRow } from '../components/Table';
import Typography from './Typography';

export default generateTestComponentMeta();

const generateBody = ({ sizes, weights, type }: PyxisTypography): TableRow[] => (
  sizes.flatMap(
    (size) => weights.map(
      (weight) => [
        <Typography size={size} weight={weight} type={type} key={size + weight} />,
        size,
        weight,
      ],
    ),
  )
);

export const Test: FC = () => (
  <Table
    head={['Sample', 'Size', 'Weight']}
    body={[pyxisTitle, pyxisText].flatMap(generateBody)}
  />
);
