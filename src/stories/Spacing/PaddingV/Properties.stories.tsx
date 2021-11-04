import { ComponentStory } from '@storybook/react';
import React from 'react';
import Spacing from '../Spacing';
import { generatePropertiesComponentMeta } from '../common';

export default generatePropertiesComponentMeta('Padding Vertical');

export const PaddingVerticalStory: ComponentStory<typeof Spacing> = ({ size }) => (
  <Spacing size={size} spacingType="PaddingV" />
);

PaddingVerticalStory.args = {
  size: 'm',
};
