import React, { FC } from 'react';
import {
  generateTestComponentMeta, text, title, TypographyRow,
} from './common';
import Table, { TableRow } from '../components/Table';
import Typography from './Typography';

export default generateTestComponentMeta();

const generateBody = ({ sizes, weights, type }: TypographyRow): TableRow[] => (
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
    body={[title, text].flatMap(generateBody)}
  />
);
