import { ComponentStory } from '@storybook/react';
import React from 'react';
import Spacing from '../Spacing';
import { generatePropertiesComponentMeta } from '../common';

export default generatePropertiesComponentMeta('Spacing Vertical');

export const SpacingVerticalStory: ComponentStory<typeof Spacing> = ({ size }) => (
  <Spacing size={size} spacingType="SpacingV" />
);

SpacingVerticalStory.args = {
  size: 'm',
};
