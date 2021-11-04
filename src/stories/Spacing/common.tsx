import React from 'react';
import { storiesOf } from '@storybook/react';
import Spacing, { SpacingSize, SpacingType } from './Spacing';

const baseTitle = 'Foundations/Spacing';
const component = Spacing;
export const spacingSizes: SpacingSize[] = ['xxxl', 'xxl', 'xl', 'l', 'm', 's', 'xs', 'xxs', 'xxxs'];

export const generatePropertiesComponentMeta: GeneratePropertiesComponentMeta<typeof Spacing> = (
  storyName,
) => ({
  title: `${baseTitle}/${storyName}/Properties`,
  component,
  argTypes: {
    spacingType: { table: { disable: true } },
  },
});

export const generateAllStoriesComponentMeta: GenerateAllStoriesComponentMeta<typeof Spacing> = (
  storyName,
) => ({
  title: `${baseTitle}/${storyName}/All Stories`,
  component,
  argTypes: {
    size: { table: { disable: true } },
    spacingType: { table: { disable: true } },
  },
  parameters: {
    controls: {
      hideNoControlsWarning: true,
    },
  },
});

export const generateAllStories: GenerateAllStories<{ spacingType: SpacingType }> = (
  module, storyName, { spacingType },
) => {
  const stories = storiesOf(`${baseTitle}/${storyName}/All Stories`, module);

  spacingSizes.forEach((size) => {
    stories.add(
      `${storyName} ${size.toUpperCase()}`,
      () => <Spacing size={size} spacingType={spacingType} />,
    );
  });
};
