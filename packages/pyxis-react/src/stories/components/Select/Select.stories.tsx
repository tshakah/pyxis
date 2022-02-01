import React from 'react';
import {ComponentMeta} from '@storybook/react';
import Select from './Select';
import renderSourceAsHTML from "../../utils/renderSourceAsHTML";

export default {
  title: 'Components/Select 🚧/All Stories',
} as ComponentMeta<typeof Select>;

export const Default = () => <div style={{marginBottom: 155}}><Select /></div>
Default.parameters = renderSourceAsHTML(Default());

export const WithError = () => <Select error />
WithError.parameters = renderSourceAsHTML(WithError());

export const WithDisabled = () => <Select disabled />
WithDisabled.parameters = renderSourceAsHTML(WithDisabled());

export const Native = () => <Select native />
Native.parameters = renderSourceAsHTML(Native());

export const WithAccessibleLabel = () =>
  <div style={{marginBottom: 155}}>
    <div className="form-item" >
      <label className="form-label" htmlFor="label-and-select">Label</label>
      <Select id="label-and-select"/>
    </div>
  </div>
WithAccessibleLabel.parameters = renderSourceAsHTML(WithAccessibleLabel());