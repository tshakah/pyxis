import { ComponentStory } from '@storybook/react';
import React from 'react';
import Spacing from '../Spacing';
import { generatePropertiesComponentMeta } from '../common';

export default generatePropertiesComponentMeta('Padding Horizontal');

export const PaddingHorizontalStory: ComponentStory<typeof Spacing> = ({ size }) => (
  <Spacing size={size} spacingType="PaddingH" />
);

PaddingHorizontalStory.args = {
  size: 'm',
};
