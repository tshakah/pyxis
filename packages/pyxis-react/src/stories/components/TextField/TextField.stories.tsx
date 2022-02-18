import React from 'react';
import {ComponentMeta} from '@storybook/react';
import TextField from './TextField';
import {IconPen} from "components/Icon/Icons";
import renderSourceAsHTML from "../../utils/renderSourceAsHTML";

export default {
  title: 'Components/Text Field 🚧/All Stories',
} as ComponentMeta<typeof TextField>;

export const Default = () => <TextField />
Default.parameters = renderSourceAsHTML(Default());

export const WithError = () => <TextField error />
WithError.parameters = renderSourceAsHTML(WithError());

export const WithHint = () => <TextField hint />
WithHint.parameters = renderSourceAsHTML(WithHint());

export const WithDisabled = () => <TextField disabled />
WithDisabled.parameters = renderSourceAsHTML(WithDisabled());

export const WithPrependIcon = () => <TextField addonIcon={IconPen} />
WithPrependIcon.parameters = renderSourceAsHTML(WithPrependIcon());

export const WithPrependText = () => <TextField addonText="€" />
WithPrependText.parameters = renderSourceAsHTML(WithPrependText());

export const WithAccessibleLabel = () => <TextField id="label-and-text-field" withLabel />
WithAccessibleLabel.parameters = renderSourceAsHTML(WithAccessibleLabel());
