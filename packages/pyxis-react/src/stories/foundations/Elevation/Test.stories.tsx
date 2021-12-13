import React, {FC} from 'react';
import Elevation from './Elevation';
import {ElevationRow, elevations, generateTestComponentMeta} from './common';
import Table, {TableRow} from 'stories/utils/Table';

export default generateTestComponentMeta();

const generateBody = ({ sizes, colors }: ElevationRow): TableRow[] => (
  colors.flatMap(
    (color) => sizes.map((size) => [
      <Elevation size={size} color={color} />,
      color,
      size,
    ]),
  ));

export const Test: FC = () => (
  <Table
    head={['Sample', 'Color', 'Size']}
    body={generateBody(elevations)}
    gridTemplateColumns="100px"
  />
);
