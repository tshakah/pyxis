import { ComponentMeta, ComponentStory } from '@storybook/react';

import React from 'react';
import Color from './Color';

export default {
  title: 'Example/Color',
  component: Color,
  argTypes: {},
} as ComponentMeta<typeof Color>;

const Template: ComponentStory<typeof Color> = (args) => <Color {...args} />;

export const ActionBase = Template.bind({});
ActionBase.args = {
  name: 'action-base',
};

export const ActionDark = Template.bind({});
ActionDark.args = {
  name: 'action-dark',
};

export const ActionLight = Template.bind({});
ActionLight.args = {
  name: 'action-light',
};

export const AlertBase = Template.bind({});
AlertBase.args = {
  name: 'alert-base',
};

export const AlertDark = Template.bind({});
AlertDark.args = {
  name: 'alert-dark',
};

export const AlertLight = Template.bind({});
AlertLight.args = {
  name: 'alert-light',
};

export const BrandBase = Template.bind({});
BrandBase.args = {
  name: 'brand-base',
};

export const BrandDark = Template.bind({});
BrandDark.args = {
  name: 'brand-dark',
};

export const BrandLight = Template.bind({});
BrandLight.args = {
  name: 'brand-light',
};

export const ErrorBase = Template.bind({});
ErrorBase.args = {
  name: 'error-base',
};

export const ErrorDark = Template.bind({});
ErrorDark.args = {
  name: 'error-dark',
};

export const ErrorLight = Template.bind({});
ErrorLight.args = {
  name: 'error-light',
};

export const Neutral25 = Template.bind({});
Neutral25.args = {
  name: 'neutral25',
};

export const Neutral50 = Template.bind({});
Neutral50.args = {
  name: 'neutral50',
};

export const Neutral75 = Template.bind({});
Neutral75.args = {
  name: 'neutral75',
};

export const Neutral85 = Template.bind({});
Neutral85.args = {
  name: 'neutral85',
};

export const Neutral95 = Template.bind({});
Neutral95.args = {
  name: 'neutral95',
};

export const NeutralBase = Template.bind({});
NeutralBase.args = {
  name: 'neutral-base',
};

export const NeutralLight = Template.bind({});
NeutralLight.args = {
  name: 'neutral-light',
};

export const SuccessBase = Template.bind({});
SuccessBase.args = {
  name: 'success-base',
};

export const SuccessDark = Template.bind({});
SuccessDark.args = {
  name: 'success-dark',
};

export const SuccessLight = Template.bind({});
SuccessLight.args = {
  name: 'success-light',
};
