import Table, {TableRow} from "../../../utils/Table";
import CopyableCode from "../../../utils/CopyableCode";
import shortid from "shortid";
import React, {FC} from "react";
import OverviewTemplate from "../../../utils/OverviewTemplate";
import {Canvas, Story} from "@storybook/addon-docs";
import OverviewIndex from "../../../utils/OverviewIndex";
import {pascalToKebab} from "../../../../commons/utils/string";

const overviewDescription = (
  <>
    <p>
      <em>
        Work in progress: React component will be developed soon. In this documentation there are only
        examples developed in HTML + SCSS.
      </em>
    </p>
    <p>
      The Form Item is used to group: label, field, error/hint or other custom HTML.
    </p>
    <p>
      All the properties described below concern the visual implementation of the component.
    </p>
  </>
);

const variantDescription = (
  <p>
    Variants of item consist on different combinations of element.
  </p>
);

const variantBody: string[] = [
  'With label',
  'With hint',
  'With error',
  'With HTML'
];

const wrapperGapDescription = (
  <p>
    Wrapper contained in the Form Item can have two different spacing: default and large.
    These can be useful when we use visual components such as CheckboxCards or RadioCards.
  </p>
);

const classDescription = (
  <p>
    Form item is based upon this list of CSS classes.
  </p>
);

const tableClassBody: TableRow[] = [
  [
    <CopyableCode text="form-item" key={shortid.generate()} />,
    'Base Class',
    <code>div</code>
  ],
  [
    <CopyableCode text="form-item__wrapper" key={shortid.generate()} />,
    'Wrapper Element',
    <code>div</code>
  ],
  [
    <CopyableCode text="form-item__wrapper--gap-large" key={shortid.generate()} />,
    'Wrapper Modifier',
    <code>div</code>
  ],
  [
    <CopyableCode text="form-item__error-message" key={shortid.generate()} />,
    'Error Message Element',
    <code>div</code>
  ],
  [
    <CopyableCode text="form-item__hint" key={shortid.generate()} />,
    'Hint Message Element',
    <code>div</code>
  ]
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Form Item 🚧" description={overviewDescription} category="Component" isMain>
      <Canvas>
        <Story id="components-form-🚧-all-stories--item-with-hint" />
      </Canvas>
    </OverviewTemplate>
    <OverviewTemplate title="Table of contents">
      <OverviewIndex titles={["Variants", "Wrapper Gap", "Overview of CSS classes"]} />
    </OverviewTemplate>
    <OverviewTemplate title="Variants" description={variantDescription}>
      {variantBody.map(variant => (
        <>
          <strong>{variant}</strong>
          <Canvas className="full-width">
            <Story id={`components-form-🚧-all-stories--item-${pascalToKebab(variant)}`} />
          </Canvas>
        </>
      ))}
    </OverviewTemplate>
    <OverviewTemplate title="Wrapper Gap" description={wrapperGapDescription}>
      <Canvas className="full-width">
        <Story id={`components-form-🚧-all-stories--item-wrapper-gap`} />
      </Canvas>
    </OverviewTemplate>
    <OverviewTemplate title="Overview of CSS classes" description={classDescription}>
      <Table
        head={['Class', 'Type', 'Apply to']}
        body={tableClassBody}
        gridTemplateColumns="1fr 200px 200px"
      />
    </OverviewTemplate>
  </>
)

export default Overview;