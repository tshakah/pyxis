import React, { FC } from 'react';
import OverviewTemplate from 'stories/components/OverviewTemplate';
import Table, { TableRow } from 'stories/components/Table';
import shortid from 'shortid';
import CopyableCode from 'stories/components/CopyableCode';
import {
  EdgeRow, edges, radius, RadiusRow,
} from './common';
import Radius from './Radius';

const radiusDescription = (
  <p>
    The border-radius property is one of the most useful and popular tools when it comes to crafting
    beautiful designs on the fly. It allows us to add rounded corners to any element
    with a few simple properties.
  </p>
);

const edgesDescription = (
  <p>
    Each radius can be used on different edges. By default the mixin use “all”.
  </p>
);

const usageDescription = (
  <p>
    Radius can be used via mixin or atomic classes. It is recommended that you use the mixin as specified in
    the user guide.
  </p>
);

const generateRadiusRow = ({ size, value }: RadiusRow): TableRow => [
  <Radius size={size} />,
  <CopyableCode text={size} key={size} />,
  <code key={value}>{value}</code>,
];

const generateEdgeRow = ({ name, value }: EdgeRow): TableRow => [
  <CopyableCode text={name} key={name} />,
  <code key={value}>{`border-radius: ${value}`}</code>,
];

const tableUsageBody: TableRow[] = [
  [
    'All radius',
    <CopyableCode text="@include radius($size)" key={shortid.generate()} />,
    <CopyableCode text=".radius-$size" key={shortid.generate()} />,
  ],
  [
    'Radius by edge',
    <CopyableCode text="@include radius($size, $edge)" key={shortid.generate()} />,
    '-',
  ],
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Radius" description={radiusDescription} category="Foundation" isMain>
      <Table
        head={['Sample', 'Size', 'Value']}
        body={radius.map(generateRadiusRow)}
        gridTemplateColumns="80px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Edges" description={edgesDescription}>
      <Table
        head={['Name', 'Value']}
        body={edges.map(generateEdgeRow)}
      />
    </OverviewTemplate>
    <OverviewTemplate title="Usage" description={usageDescription}>
      <Table
        head={['Name', 'Mixin', 'Atomic class']}
        body={tableUsageBody}
        gridTemplateColumns="20%"
      />
    </OverviewTemplate>
  </>
);

export default Overview;
