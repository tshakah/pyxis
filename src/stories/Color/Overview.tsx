import React, { FC } from 'react';
import OverviewTemplate from 'stories/components/OverviewTemplate';
import Table, { TableRow } from 'stories/components/Table';
import shortid from 'shortid';
import { pascalToKebab } from 'utils';
import CopyableCode from 'stories/components/CopyableCode';
import { pyxisColors, PyxisColor } from './common';
import Color from './Color';

const colorDescription = (
  <>
    <p>
      Defining colors in a design system is a way to make sure our brand stays consistent across all areas of our business,
      from the website to the marketing material, and everywhere in between.
    </p>
    <p>
      Guidelines
      Use the colors provided in Pyxis. These have been tested to ensure they meet or exceed accessibility guidelines.
    </p>
    <p>
      <strong>Don&apos;t</strong>
      : Please, never use any additional colors. Always stick to our official palette.
    </p>
  </>
);

const gradientDescription = (
  <p>
    Use gradient backgrounds to make a component stand out!
  </p>
);

const usageDescription = (
  <p>
    Colors can be used via functions and atomic classes.
    It is recommended that you use the functions as specified in the user guide.
  </p>
);

const generateRow = ({ name, value, type }: PyxisColor): TableRow => [
  <Color name={pascalToKebab(name)} key={pascalToKebab(name)} type={type} />,
  <CopyableCode text={name} key={name} />,
  <code key={value}>{value}</code>,
];

const tableUsageBody: TableRow[] = [
  [
    'Background Color',
    <CopyableCode text="color($key)" key={shortid.generate()} />,
    <CopyableCode text=".bg-$key" key={shortid.generate()} />,
  ],
  [
    'Color',
    <CopyableCode text="color($key)" key={shortid.generate()} />,
    <CopyableCode text=".c-$key" key={shortid.generate()} />,
  ],
  [
    'Gradient',
    <CopyableCode text="gradient($key)" key={shortid.generate()} />,
    <CopyableCode text=".gradient-$key" key={shortid.generate()} />,
  ],
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Colors" description={colorDescription} category="Foundation" isMain>
      <Table
        head={['Sample', 'Key', 'Value']}
        body={pyxisColors.filter(({ type }) => type === 'solid').map(generateRow)}
        gridTemplateColumns="100px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Gradients" description={gradientDescription}>
      <Table
        head={['Sample', 'Key', 'Value']}
        body={pyxisColors.filter(({ type }) => type === 'gradient').map(generateRow)}
        gridTemplateColumns="100px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Usage" description={usageDescription}>
      <Table
        head={['Name', 'Function', 'Atomic class']}
        body={tableUsageBody}
      />
    </OverviewTemplate>
  </>
);

export default Overview;
