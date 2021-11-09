import { storiesOf } from '@storybook/react';
import React from 'react';
import Radius, { RadiusSize } from './Radius';

const baseTitle = 'Foundations/Radius';
const component = Radius;
const radiusSizes: RadiusSize[] = ['xl', 'l', 'm', 's', 'xs'];

export const generatePropertiesComponentMeta: GeneratePropertiesComponentMeta<typeof component> = () => ({
  title: `${baseTitle}/Properties`,
  component,
});

export const generateAllStoriesComponentMeta: GenerateAllStoriesComponentMeta<typeof component> = () => ({
  title: `${baseTitle}/All Stories`,
  component,
  argTypes: {
    size: { table: { disable: true } },
  },
  parameters: {
    controls: {
      hideNoControlsWarning: true,
    },
  },
});

export const generateAllStories: GenerateAllStories<undefined> = (
  module, storyName,
) => {
  const stories = storiesOf(`${baseTitle}/All Stories`, module);

  radiusSizes.forEach((size) => {
    stories.add(
      `${storyName} ${size.toUpperCase()}`,
      () => <Radius size={size} />,
    );
  });
};
