import React, {FC} from "react";
import Table, {TableRow} from "stories/utils/Table";
import CopyableCode from "stories/utils/CopyableCode";
import shortid from "shortid";
import OverviewTemplate from "stories/utils/OverviewTemplate";
import {Canvas, Story} from "@storybook/addon-docs";
import OverviewIndex from "stories/utils/OverviewIndex";
import Badge from "./Badge";

const overviewDescription = (
  <>
    <p>
      <em>
        Work in progress: React component will be developed soon. In this documentation there are only
        examples developed in HTML + SCSS.
      </em>
    </p>
    <p>
      Badges are labels which hold small amounts of information. They are composed of text inside
      a <code>span</code> element.
    </p>
  </>
);

const variantDescription = (
  <p>
    Variants of badge consist on different combinations of colours and each of them conveys a different
    meaning to the user.
  </p>
);

const generateVariantBody = (): TableRow[] =>  [
  [
    <Badge key={shortid.generate()}/>,
    'Default',
    '-'
  ],
  [
    <Badge variant="brand" key={shortid.generate()}/>,
    'Brand',
    '-'
  ],
  [
    <Badge variant="action" key={shortid.generate()}/>,
    'Action',
    '-'
  ],
  [
    <Badge variant="success" key={shortid.generate()}/>,
    'Success',
    '-'
  ],
  [
    <Badge variant="alert" key={shortid.generate()}/>,
    'Alert',
    '-'
  ],
  [
    <Badge variant="error" key={shortid.generate()}/>,
    'Error',
    '-'
  ],
  [
    <Badge variant="neutralGradient" key={shortid.generate()}/>,
    'Neutral Gradient',
    'Available only on light background'
  ],
  [
    <Badge variant="brandGradient" key={shortid.generate()}/>,
    'Brand Gradient',
    'Available only on light background'
  ],
  [
    <div className="alt-wrapper" key={shortid.generate()}>
      <Badge ghost alt/>
    </div>,
    'Ghost',
    'Available only on dark background'
  ]
];

const altDescription = (
  <p>
    Some variants of badges support also an "alt" version for dark background.
  </p>
);

const generateAltBody = (): TableRow[] =>  [
  [
    <div className="alt-wrapper" key={shortid.generate()} >
      <Badge alt />
    </div>,
    'Alt version',
  ]
];

const classDescription = (
  <p>
    Badge is based upon this list of CSS classes.
  </p>
);

const tableClassBody: TableRow[] = [
  [
    <CopyableCode text="badge" key={shortid.generate()} />,
    'Base Class',
    '-',
  ],
  [
    <CopyableCode text="badge--brand" key={shortid.generate()} />,
    'Variant Modifier',
    '-',
  ],
  [
    <CopyableCode text="badge--action" key={shortid.generate()} />,
    'Variant Modifier',
    '-',
  ],
  [
    <CopyableCode text="badge--success" key={shortid.generate()} />,
    'Variant Modifier',
    '-',
  ],
  [
    <CopyableCode text="badge--alert" key={shortid.generate()} />,
    'Variant Class',
    '-',
  ],
  [
    <CopyableCode text="badge--error" key={shortid.generate()} />,
    'Variant Class',
    '-',
  ],
  [
    <CopyableCode text="badge--neutral-gradient" key={shortid.generate()} />,
    'Variant Class',
    'Don\'t use it with `badge--alt`.',
  ],
  [
    <CopyableCode text="badge--brand-gradient" key={shortid.generate()} />,
    'Variant Class',
    'Don\'t use it with `badge--alt`.',
  ],
  [
    <CopyableCode text="badge--ghost" key={shortid.generate()} />,
    'Variant Class',
    'Use it only with `badge--alt`.',
  ],
  [
    <CopyableCode text="badge--alt" key={shortid.generate()} />,
    'Alternative Background Class',
    '-',
  ],
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Badge 🚧" description={overviewDescription} category="Component" isMain>
      <Canvas>
        <Story id="components-badge-🚧-all-stories--default" />
      </Canvas>
    </OverviewTemplate>
    <OverviewTemplate title="Table of contents">
      <OverviewIndex titles={["Variants", "Alt Background", "Overview of CSS classes"]} />
    </OverviewTemplate>
    <OverviewTemplate title="Variants" description={variantDescription}>
      <Table
        head={['Sample', 'Variant', 'Note']}
        body={generateVariantBody()}
        gridTemplateColumns="100px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Alt Background" description={altDescription}>
      <Table
        head={['Sample', 'State']}
        body={generateAltBody()}
        gridTemplateColumns="100px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Overview of CSS classes" description={classDescription}>
      <Table
        head={['Class', 'Type', 'Note']}
        body={tableClassBody}
        gridTemplateColumns="300px 1fr 1fr"
      />
    </OverviewTemplate>
  </>
)

export default Overview;