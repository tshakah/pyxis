import { ComponentStory } from '@storybook/react';
import { generatePropertiesComponentMeta } from './common';
import Radius from './Radius';

export default generatePropertiesComponentMeta();

export const RadiusStory: ComponentStory<typeof Radius> = ({ size }) => <Radius size={size} />;

RadiusStory.args = {
  size: 'm',
};
