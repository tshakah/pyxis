import { ComponentMeta, ComponentStory } from '@storybook/react';
import React from 'react';
import Color from './Color';
import { storyTitleGenerator } from './Story.config';

const componentMeta: ComponentMeta<typeof Color> = {
  title: storyTitleGenerator('Properties'),
  component: Color,
  argTypes: {
    name: { controls: false },
  },
};

export default componentMeta;

export const ColorStory: ComponentStory<typeof Color> = ({ name }) => (
  <Color name={name} />
);

ColorStory.args = {
  name: 'action-base',
};
