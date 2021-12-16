import React from 'react';

import {ComponentMeta, ComponentStory} from '@storybook/react';
import {IconAccessKey} from "../../components/Icon/Icons";

// TODO: replace with a proper story.
export default {
  title: 'Components/Icons/Icon',
  component: IconAccessKey,
} as ComponentMeta<typeof IconAccessKey>;

export const Primary: ComponentStory<typeof IconAccessKey> = () => <IconAccessKey description="questa è una descrizione per l'accessibilità"/>;