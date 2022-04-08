import React, {FC} from 'react';
import OverviewTemplate from 'stories/utils/OverviewTemplate';
import Table, {TableRow} from 'stories/utils/Table';
import shortid from 'shortid';
import CopyableCode from 'stories/utils/CopyableCode';
import {containerWithFixedWidth, LayoutRow, breakpointsWithContainer, breakpoints} from './common';

const layoutDescription = (
  <>
    <p>
      Layout is the page structure in which content and components live.
    </p>
    <p>
      To make sure that our products give the same experience on different types of devices we use grids, that also help us create harmony and a responsive experience on every size.
    </p>
  </>
);

const containerDescription = (
  <p>
    Container is used to center your content horizontally. The max width can be change with modifiers.
  </p>
);

const breakpointsDescription = (
  <p>
    Pyxis provides seven breakpoints that are uniform across all themes to maintain a consistent set of conditions when designing experiences.
    <br />
    The breakpoints and the entire Design System use the mobile first approach.
  </p>
);

const responsiveContainerDescription = (
  <p>
    The following table shows all the breakpoints with the relative max-width of the responsive containers.
  </p>
);

const containerWithFixedWidthDescription = (
  <p>
    Pyxis also allows you to use container with a fixed <code>max-width</code> on all breakpoints above <code>xsmall (576px)</code>.
  </p>
);

const usageDescription = (
  <p>
    Containers can be used via mixin and atomic classes.
  </p>
);

const generateContainerRow = ({ name, value, maxWidth }: LayoutRow): TableRow => [
  <CopyableCode text={name} key={name} />,
  <code key={value}>{value}</code>,
  <code>{maxWidth}</code>
];

const generateFixedContainerRow = ({ name, value }: LayoutRow): TableRow => [
  <CopyableCode text={name} key={name} />,
  <code key={value}>{value}px</code>
];

const tableClassBody: TableRow[] = [
  [
    <CopyableCode text="container-responsive" key={shortid.generate()} />,
    <CopyableCode text="containerResponsive()" key={shortid.generate()} />,
    'Apply the responsive container on every breakpoints.'
  ],
  [
    <CopyableCode text="container-responsive-from-$bp" key={shortid.generate()} />,
    <CopyableCode text="containerResponsive($fromBp)" key={shortid.generate()} />,
    'Apply the responsive container from specific breakpoint, before that the container will be full-width. '
  ],
  [
    '-',
    <CopyableCode text="containerResponsive($fromBp, $untilBp)" key={shortid.generate()} />,
    'You can use the same mixin to apply the responsive container on specific range of breakpoints.',
  ],
  [
    <CopyableCode text="container-$fixedContainerSize" key={shortid.generate()} />,
    <CopyableCode text="containerWithFixedSize($size)" key={shortid.generate()} />,
    'Apply the fixed container on all breakpoints after xsmall.'
  ],
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Layout" description={layoutDescription} category="Foundation" isMain />
    <OverviewTemplate title="Breakpoints" description={breakpointsDescription}>
      <Table
        head={['Key', 'Value']}
        body={breakpoints.map(generateFixedContainerRow)}
        size="small"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Container" description={containerDescription}>
      <h3 className="title-s-bold c-neutral-base">Responsive Container</h3>
      {responsiveContainerDescription}
      <Table
        head={['Key', 'Value', 'Max Width']}
        body={breakpointsWithContainer.map(generateContainerRow)}
        size="small"
      />
      <h3 className="title-s-bold c-neutral-base">Container with fixed width</h3>
      {containerWithFixedWidthDescription}
      <Table
        head={['Key', 'Max Width']}
        body={containerWithFixedWidth.map(generateFixedContainerRow)}
        size="small"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Usage" description={usageDescription}>
      <Table
        head={['Atomic class', 'Mixin', 'Note']}
        body={tableClassBody}
        gridTemplateColumns="280px 340px"
      />
    </OverviewTemplate>
  </>
);

export default Overview;
