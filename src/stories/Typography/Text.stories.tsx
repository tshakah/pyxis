import { ComponentMeta, ComponentStory } from '@storybook/react';

import React from 'react';
import Text from './Text';

export default {
  title: 'Foundations/Typography/Text',
  component: Text,
  argTypes: {},
} as ComponentMeta<typeof Text>;

const Template: ComponentStory<typeof Text> = (args) => <Text {...args} />;

export const TextToken = Template.bind({});
TextToken.args = {
  size: 'l',
  weight: 'book',
};
