import { ComponentStory } from '@storybook/react';
import React from 'react';
import Spacing from '../Spacing';
import { generatePropertiesComponentMeta } from '../common';

export default generatePropertiesComponentMeta('Row Gap');

export const RowGapStory: ComponentStory<typeof Spacing> = ({ size }) => (
  <Spacing size={size} spacingType="RowGap" />
);

RowGapStory.args = {
  size: 'm',
};
