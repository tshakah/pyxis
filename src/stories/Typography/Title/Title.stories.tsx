import { ComponentMeta, storiesOf } from '@storybook/react';
import React from 'react';
import Title, { TitleSize, TitleWeight } from './Title';
import { capitalize } from '../../../utils';

const storyTitle = 'Foundations/Typography/Title/All Stories';

const componentMeta: ComponentMeta<typeof Title> = {
  title: storyTitle,
  component: Title,
  argTypes: {},
};

export default componentMeta;

const stories = storiesOf(storyTitle, module);
const titleSizes: TitleSize[] = ['xl', 'l', 'm', 's'];
const titleWeight: TitleWeight[] = ['book', 'bold'];

titleSizes.forEach((size) => {
  titleWeight.forEach((weight) => {
    const storyName = `Title ${size.toUpperCase()} - ${capitalize(weight)}`;
    stories.add(storyName, () => (<Title size={size} weight={weight} />));
  });
});
