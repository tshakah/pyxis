import { ComponentMeta, ComponentStory } from '@storybook/react';

import React from 'react';
import Color from './Color';

export default {
  title: 'Foundations/Colors/Properties',
  component: Color,
  argTypes: {
    name: { controls: false },
  },
} as ComponentMeta<typeof Color>;

const Template: ComponentStory<typeof Color> = (args) => <Color {...args} />;

export const ColorToken = Template.bind({});
ColorToken.args = {
  name: 'action-base',
};
