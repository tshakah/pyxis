import React, { FC } from "react";
import {Canvas, Story} from "@storybook/addon-docs";
import OverviewTemplate from "stories/utils/OverviewTemplate";
import OverviewIndex from "stories/utils/OverviewIndex";
import Table, {TableRow} from "stories/utils/Table";
import TextField from "./TextField";
import {IconPlate} from "components/Icon/Icons";
import CopyableCode from "stories/utils/CopyableCode";
import shortid from "shortid";

const overviewDescription = (
  <>
    <p>
      <em>
        Work in progress: React component will be developed soon. In this documentation there are only
        examples developed in HTML + SCSS.
      </em>
    </p>
    <p>
      Text fields are used when the user should include short form content, including text, numbers, e-mail addresses, or passwords.
    </p>
    <p>
      All the properties described below concern the visual implementation of the component.
    </p>
  </>
);

const stateDescription = (
  <>
    <p>
      Text fields have default (with placeholder), hover, focus, filled, error and disable states.
    </p>
    <p>
      <strong className="text-l-bold">Hint:</strong> Interact with components to see hover and focus states.
    </p>
  </>
);

const generateStateBody = (): TableRow[] => [
  [
    <TextField />,
    "Default",
  ],
  [
    <TextField value="Text Field"/>,
    "Filled / Validate",
  ],
  [
    <TextField error />,
    "Error",
  ],
  [
    <TextField disabled />,
    "Disabled",
  ],
];

const addonDescription = (
  <>
    <p>
      Text field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
    </p>
    <p>
      <strong className="text-l-bold">Please Note:</strong> use these addons one at a time.
    </p>
  </>
);

const generateAddonBody = (): TableRow[] => [
  [
    <TextField addonIcon={IconPlate} />,
    "Icon Prepend",
  ],
  [
    <TextField addonIcon={IconPlate} addonPlacement="append" />,
    "Icon Append",
  ],
  [
    <TextField addonText="€" />,
    "Text Prepend",
  ],
  [
    <TextField addonText="mq" addonPlacement="append" />,
    "Text Append",
  ],
];

const sizeDescription = (
  <p>
    Text field can have two size: default or small.
  </p>
);

const generateSizeBody = (): TableRow[] => [
  [
    <TextField />,
    "Default",
  ],
  [
    <TextField size="small" />,
    "Small",
  ],
  [
    <TextField size="small" addonIcon={IconPlate}/>,
    "Small with Icon",
  ],
  [
    <TextField size="small" addonText="€"/>,
    "Small with Text",
  ],
];

const accessibilityDescription = (
  <>
    <p>
      Whenever possible, use the label element to associate text with form elements explicitly.
      The <code>for</code> attribute of the label must exactly match the <code>id</code> of the form input.
    </p>
    <p>
      When a error message is present, please remember that it also should be connected to the group
      by adding a proper id to the message and the <code>aria-describedby</code> attribute to the group.
    </p>
    <Canvas>
      <Story id="components-text-field-🚧-all-stories--with-accessible-label" />
    </Canvas>
  </>
);

const classDescription = (
  <p>
    Text Field is based upon this list of CSS classes.
  </p>
);

const tableClassBody: TableRow[] = [
  [
    <CopyableCode text="form-field" key={shortid.generate()} />,
    'Base Class',
    <code>div</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field--error" key={shortid.generate()} />,
    'State Modifier',
    <code>div</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field--disabled" key={shortid.generate()} />,
    'State Modifier',
    <code>div</code>,
    'Use it along with the `disabled` attribute on input',
  ],
  [
    <CopyableCode text="form-field--with-prepend-text" key={shortid.generate()} />,
    'Addon Modifier',
    <code>div</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field--with-append-text" key={shortid.generate()} />,
    'Addon Modifier',
    <code>div</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field--with-prepend-icon" key={shortid.generate()} />,
    'Addon Modifier',
    <code>div</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field--with-append-icon" key={shortid.generate()} />,
    'Addon Modifier',
    <code>div</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field__wrapper" key={shortid.generate()} />,
    'Component Wrapper',
    <code>label</code>,
    'It is only used if there is a visible addon',
  ],
  [
    <CopyableCode text="form-field__addon" key={shortid.generate()} />,
    'Base Class',
    <code>div</code>,
    'It is only used if there is a visible addon',
  ],
  [
    <CopyableCode text="form-field__text" key={shortid.generate()} />,
    'Input Element',
    <code>input</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field__text--small" key={shortid.generate()} />,
    'Input Modifier',
    <code>input</code>,
    '-',
  ],
  [
    <CopyableCode text="form-field__error-message" key={shortid.generate()} />,
    'Error Element',
    <code>div</code>,
    '-',
  ]
];

const Overview: FC = () => (
  <>
    <OverviewTemplate title="Text Field 🚧" description={overviewDescription} category="Component" isMain>
      <Canvas>
        <Story id="components-text-field-🚧-all-stories--default" />
      </Canvas>
    </OverviewTemplate>
    <OverviewTemplate title="Table of contents">
      <OverviewIndex titles={["State", "Addon", "Size", "Accessibility", "Overview of CSS classes"]} />
    </OverviewTemplate>
    <OverviewTemplate title="State" description={stateDescription}>
      <Table
        head={['Sample', 'State']}
        body={generateStateBody()}
        gridTemplateColumns="320px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Addon" description={addonDescription}>
      <Table
        head={['Sample', 'Addon']}
        body={generateAddonBody()}
        gridTemplateColumns="320px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Size" description={sizeDescription}>
      <Table
        head={['Sample', 'Size']}
        body={generateSizeBody()}
        gridTemplateColumns="320px"
      />
    </OverviewTemplate>
    <OverviewTemplate title="Accessibility" description={accessibilityDescription} />
    <OverviewTemplate title="Overview of CSS classes" description={classDescription}>
      <Canvas>
        <Story id="components-text-field-🚧-all-stories--with-prepend-icon" />
      </Canvas>
      <Table
        head={['Class', 'Type', 'Apply to', 'Note']}
        body={tableClassBody}
        gridTemplateColumns="300px 1fr 100px 2fr"
      />
    </OverviewTemplate>
  </>
)

export default Overview;