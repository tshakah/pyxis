import React from 'react';
import {ComponentMeta} from '@storybook/react';
import TextArea from './TextArea';
import renderSourceAsHTML from "../../utils/renderSourceAsHTML";

export default {
  title: 'Components/Text Area 🚧/All Stories',
} as ComponentMeta<typeof TextArea>;

export const Default = () => <TextArea />
Default.parameters = renderSourceAsHTML(Default());

export const WithError = () => <TextArea error />
WithError.parameters = renderSourceAsHTML(WithError());

export const WithDisabled = () => <TextArea disabled />
WithDisabled.parameters = renderSourceAsHTML(WithDisabled());

export const WithAccessibleLabel = () =>
  <>
    <div className="form-item">
      <label className="form-label" htmlFor="label-and-text-area">Label</label>
      <TextArea id="label-and-text-area"/>
    </div>
  </>
WithAccessibleLabel.parameters = renderSourceAsHTML(WithAccessibleLabel());