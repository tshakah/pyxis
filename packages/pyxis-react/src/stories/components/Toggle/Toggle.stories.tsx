import React from 'react';
import {ComponentMeta} from '@storybook/react';
import renderSourceAsHTML from "stories/utils/renderSourceAsHTML";
import Toggle from "./Toggle";

export default {
  title: 'Components/Toggle 🚧/All Stories',
} as ComponentMeta<typeof Toggle>;

export const Default = () => <Toggle />
Default.parameters = renderSourceAsHTML(Default());

export const WithLabel = () => <Toggle label />
WithLabel.parameters = renderSourceAsHTML(WithLabel());

export const Disabled = () => <Toggle disabled />
Disabled.parameters = renderSourceAsHTML(Disabled());
