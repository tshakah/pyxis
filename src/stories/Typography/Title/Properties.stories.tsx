import { ComponentMeta, ComponentStory } from '@storybook/react';
import React from 'react';
import Title from './Title';

const componentMeta: ComponentMeta<typeof Title> = {
  title: 'Foundations/Typography/Title/Properties',
  component: Title,
  argTypes: {
    size: { controls: false },
    weight: { controls: false },
  },
};

export default componentMeta;

export const TitleStory: ComponentStory<typeof Title> = ({ size, weight }) => (
  <Title size={size} weight={weight} />
);

TitleStory.args = {
  size: 'm',
  weight: 'book',
};
