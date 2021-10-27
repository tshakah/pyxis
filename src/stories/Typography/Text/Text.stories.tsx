import { ComponentMeta, storiesOf } from '@storybook/react';
import React from 'react';
import { capitalize } from '../../../utils';
import Text from './index';
import { TextSize, TextWeight } from './Text';

const storyTitle = 'Foundations/Typography/Text/All Stories';

const componentMeta: ComponentMeta<typeof Text> = {
  title: storyTitle,
  component: Text,
  argTypes: {},
};

export default componentMeta;

const stories = storiesOf(storyTitle, module);
const textSizes: TextSize[] = ['l', 'm', 's'];
const textWeights: TextWeight[] = ['light', 'book', 'bold'];

textSizes.forEach((textSize) => {
  textWeights.forEach((textWeight) => {
    const storyName = `Text ${textSize.toUpperCase()} - ${capitalize(textWeight)}`;
    stories.add(storyName, () => <Text size={textSize} weight={textWeight} />);
  });
});
