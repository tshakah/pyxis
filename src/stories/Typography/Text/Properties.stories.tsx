import { ComponentMeta, ComponentStory } from '@storybook/react';
import React from 'react';
import Text from './Text';

const componentMeta: ComponentMeta<typeof Text> = {
  title: 'Foundations/Typography/Text/Properties',
  component: Text,
  argTypes: {
    size: { controls: false },
    weight: { controls: false },
  },
};

export default componentMeta;

export const TextStory: ComponentStory<typeof Text> = ({ size, weight }) => (
  <Text size={size} weight={weight} />
);

TextStory.args = {
  size: 'm',
  weight: 'book',
};
