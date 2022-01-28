import React from 'react';
import {ComponentMeta} from '@storybook/react';
import {RadioGroup} from "./Radio";
import renderSourceAsHTML from "../../utils/renderSourceAsHTML";

export default {
  title: 'Components/Radio 🚧/All Stories',
} as ComponentMeta<typeof RadioGroup>;

export const Default = () => <RadioGroup name="default"/>
Default.parameters = renderSourceAsHTML(Default());

export const WithError = () => <RadioGroup name="error" error/>
WithError.parameters = renderSourceAsHTML(WithError());

export const Disabled = () => <RadioGroup name="disabled" disabled/>
Disabled.parameters = renderSourceAsHTML(Disabled());