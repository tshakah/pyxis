import { ComponentStory } from '@storybook/react';
import React from 'react';
import Spacing from '../Spacing';
import { generatePropertiesComponentMeta } from '../common';

export default generatePropertiesComponentMeta('Padding');

export const PaddingStory: ComponentStory<typeof Spacing> = ({ size }) => (
  <Spacing size={size} spacingType="Padding" />
);

PaddingStory.args = {
  size: 'm',
};
