import React from 'react';
import {ComponentMeta} from '@storybook/react';
import DateField from './DateField';
import renderSourceAsHTML from "../../utils/renderSourceAsHTML";

export default {
  title: 'Components/Date Field 🚧/All Stories',
} as ComponentMeta<typeof DateField>;

export const Default = () => <DateField />
Default.parameters = renderSourceAsHTML(Default());

export const WithError = () => <DateField error />
WithError.parameters = renderSourceAsHTML(WithError());

export const WithDisabled = () => <DateField disabled />
WithDisabled.parameters = renderSourceAsHTML(WithDisabled());

export const WithAccessibleLabel = () =>
  <>
    <div className="form-item">
      <label className="form-label" htmlFor="label-and-date-field">Label</label>
      <DateField id="label-and-date-field"/>
    </div>
  </>
WithAccessibleLabel.parameters = renderSourceAsHTML(WithAccessibleLabel());