import { ComponentStory } from '@storybook/react';
import React from 'react';
import Spacing from '../Spacing';
import { generatePropertiesComponentMeta } from '../common';

export default generatePropertiesComponentMeta('Spacing Horizontal');

export const SpacingHorizontalStory: ComponentStory<typeof Spacing> = ({ size }) => (
  <Spacing size={size} spacingType="SpacingH" />
);

SpacingHorizontalStory.args = {
  size: 'm',
};
