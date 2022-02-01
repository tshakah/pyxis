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

export const WithDisabled = () => <TextField disabled />
WithDisabled.parameters = renderSourceAsHTML(WithDisabled());

export const WithPrependIcon = () => <TextField addonIcon={IconPen} />
WithPrependIcon.parameters = renderSourceAsHTML(WithPrependIcon());

export const WithPrependText = () => <TextField addonText="€" />
WithPrependText.parameters = renderSourceAsHTML(WithPrependText());

export const WithAccessibleLabel = () =>
  <>
    <div className="form-item">
      <label className="form-label" htmlFor="label-and-text-field">Label</label>
      <TextField id="label-and-text-field"/>
    </div>
  </>
WithAccessibleLabel.parameters = renderSourceAsHTML(WithAccessibleLabel());
