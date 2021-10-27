import { ComponentMeta, storiesOf } from '@storybook/react';
import React from 'react';
import Color from './Color';
import docs from './docs.mdx';
import { capitalize } from '../../utils';
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
  const storyName = pyxisClass.split('-').map((s) => capitalize(s)).join(' ');
  stories.add(
    storyName,
    () => <Color name={pyxisClass} />,
  );
});
