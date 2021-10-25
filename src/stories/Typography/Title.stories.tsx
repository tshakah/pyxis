import { ComponentMeta, ComponentStory } from '@storybook/react';

import React from 'react';
import Title from './Title';

export default {
  title: 'Foundations/Typography/Title',
  component: Title,
  argTypes: {},
} as ComponentMeta<typeof Title>;

const Template: ComponentStory<typeof Title> = (args) => <Title {...args} />;

export const TitleToken = Template.bind({});
TitleToken.args = {
  size: 'xl',
  weight: 'bold',
};
