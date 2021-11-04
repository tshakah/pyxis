import { ComponentStory } from '@storybook/react';
import React from 'react';
import Spacing from '../Spacing';
import { generatePropertiesComponentMeta } from '../common';

export default generatePropertiesComponentMeta('Column Gap');

export const ColumnGapStory: ComponentStory<typeof Spacing> = ({ size }) => (
  <Spacing size={size} spacingType="ColumnGap" />
);

ColumnGapStory.args = {
  size: 'm',
};
