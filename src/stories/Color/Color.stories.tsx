import { ComponentMeta, storiesOf } from '@storybook/react';
import React from 'react';
import { kebabToStartCase } from 'utils';
import Color from './Color';
import docs from './docs.mdx';
import { pyxisColors, storyTitleGenerator } from './Story.config';

const title = storyTitleGenerator('All Stories');

const componentMeta: ComponentMeta<typeof Color> = {
  title,
  component: Color,
  argTypes: {
    name: {
      table: { disable: true },
    },
  },
  parameters: {
    docs: {
      page: docs,
    },
    controls: {
      hideNoControlsWarning: true,
    },
  },
};

export default componentMeta;

const stories = storiesOf(title, module);

pyxisColors.forEach((pyxisClass) => {
  stories.add(
    kebabToStartCase(pyxisClass),
    () => <Color name={pyxisClass} />,
  );
});
