import React, {FC} from 'react';
import OverviewTemplate from 'stories/utils/OverviewTemplate';
import shortid from 'shortid';
import {ElevationRow, elevations} from './common';
import Table, {TableRow} from 'stories/utils/Table';
import CopyableCode from 'stories/utils/CopyableCode';
import Elevation from './Elevation';

const description = (
  <>
    <p>
      Elevation is the relative distance between two surfaces along the z-axis.
    </p>
    <p>
      It&apos;s a way of thinking that&apos;s less about the actual aesthetic and more about creating an experience
      that feels like it was designed by Google. Material Design is where shadows were born: a simple concept to
      effectively represent elevation on the screen.
    </p>
  </>
);

const usageDescription = (
  <>
    <p>
      Elevation can be used via mixin and atomic classes.
      It is recommended that you use the mixin as specified in the user guide.
    </p>
    <p>
      <strong>Please note</strong>
      : Remember to generate the atomic class with the kebab-case version of the&nbsp;
      <code>$color</code>
      &nbsp;key - e.g. atomic class for &quot;brand15&quot; color with size &quot;s&quot; will be&nbsp;
      <code>.elevation-s-brand-15 </code>
      .
    </p>
  </>
);

const generateBody = ({ sizes, colors }: ElevationRow): TableRow[] => (
  colors.flatMap(
    (color) => sizes.map((size) => [
      <Elevation size={size} color={color} key={shortid.generate()} />,
      <CopyableCode text={color} key={shortid.generate()} />,
      <CopyableCode text={size} key={shortid.generate()} />,
    ]),
  ));

const tableUsageBody: TableRow[] = [
  [
    'Elevation',
    <CopyableCode text="@include elevation($size, $color)" key={shortid.generate()} />,
    <CopyableCode text=".elevation-$size-$color" key={shortid.generate()} />,
  ],
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Elevation" description={description} category="Foundation" isMain>
      <Table
        head={['Sample', 'Color and Opacity', 'Size']}
        body={generateBody(elevations)}
        gridTemplateColumns="100px"
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
