import React, { FC } from 'react';
import OverviewTemplate from 'stories/components/OverviewTemplate';
import Table, { TableRow } from 'stories/components/Table';
import shortid from 'shortid';
import CopyableCode from 'stories/components/CopyableCode';
import { spacing, SpacingRow } from './common';
import Spacing from './Spacing';

const spacingDescription = (
  <>
    <p>
      With almost endless combinations of font, images, and spacing available to use in our designs,
      it&apos;s easy to fall into the trap of sticking with what you know. But if we want people to take
      our interface seriously, we must consider the importance of spacing consistency among all the elements.
    </p>
    <p>
      Spacing helps page components breathe. The Pyxis spacing system utilises a system of responsive spacers
      that are dynamic across different breakpoints. This allows the information on the page to adapt to
      any screen size. Every part of a UI should be intentional including the empty space between elements.
      The amount of space between items creates relationships and hierarchy.
    </p>
  </>
);

const usageDescription = (
  <p>
    Spacing can be used via mixins and atomic classes.
    It is recommended that you use the functions as specified in the user guide.
  </p>
);

const generateRow = ({ size, baseValue, maxValue }: SpacingRow): TableRow => [
  <Spacing size={size} key={size + baseValue} />,
  <CopyableCode text={size} key={size} />,
  <code key={baseValue}>{baseValue}</code>,
  <code key={maxValue}>{maxValue}</code>,
];

const tableUsageBody: TableRow[] = [
  [
    'Padding',
    <CopyableCode text="@include padding($size)" key={shortid.generate()} />,
    <CopyableCode text=".padding-$size" key={shortid.generate()} />,
  ],
  [
    'Vertical padding',
    <CopyableCode text="@include verticalPadding($size)" key={shortid.generate()} />,
    <CopyableCode text=".padding-v-$size" key={shortid.generate()} />,
  ],
  [
    'Horizontal padding',
    <CopyableCode text="@include horizontalPadding($size)" key={shortid.generate()} />,
    <CopyableCode text=".padding-h-$size" key={shortid.generate()} />,
  ],
  [
    'Vertical spacing',
    <CopyableCode text="@include verticalSpacing($size)" key={shortid.generate()} />,
    <CopyableCode text=".spacing-v-$size" key={shortid.generate()} />,
  ],
  [
    'Horizontal spacing',
    <CopyableCode text="@include horizontalSpacing($size)" key={shortid.generate()} />,
    <CopyableCode text=".spacing-h-$size" key={shortid.generate()} />,
  ],
  [
    'Row gap',
    <CopyableCode text="@include rowGap($size)" key={shortid.generate()} />,
    <CopyableCode text=".row-gap-$size" key={shortid.generate()} />,
  ],
  [
    'Column gap',
    <CopyableCode text="@include columnGap($size)" key={shortid.generate()} />,
    <CopyableCode text=".column-gap-$size" key={shortid.generate()} />,
  ],
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Spacing" description={spacingDescription} category="Foundation" isMain>
      <Table
        head={['Sample', 'Size', 'Base Value', 'Max Value']}
        body={spacing.map(generateRow)}
        gridTemplateColumns="120px"
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
