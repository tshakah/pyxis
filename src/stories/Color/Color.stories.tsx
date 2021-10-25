import { ComponentMeta, ComponentStory } from '@storybook/react';

import React from 'react';
import Color from './Color';
import docs from './docs.mdx';

export default {
  title: 'Foundations/Colors/All Stories',
  component: Color,
  argTypes: {
    name: {
      table: { disable: true },
    },
  },
  parameters: {
    docs: {
      page: docs,
    },
    controls: {
      hideNoControlsWarning: true,
    },
  },
} as ComponentMeta<typeof Color>;

export const ActionBaseToken: ComponentStory<typeof Color> = () => <Color name="action-base" />;
export const ActionDarkToken: ComponentStory<typeof Color> = () => <Color name="action-dark" />;
export const ActionLightToken: ComponentStory<typeof Color> = () => <Color name="action-light" />;
export const AlertBaseToken: ComponentStory<typeof Color> = () => <Color name="alert-base" />;
export const AlertDarkToken: ComponentStory<typeof Color> = () => <Color name="alert-dark" />;
export const AlertLightToken: ComponentStory<typeof Color> = () => <Color name="alert-light" />;
export const BrandBaseToken: ComponentStory<typeof Color> = () => <Color name="brand-base" />;
export const BrandDarkToken: ComponentStory<typeof Color> = () => <Color name="brand-dark" />;
export const BrandLightToken: ComponentStory<typeof Color> = () => <Color name="brand-light" />;
export const ErrorBaseToken: ComponentStory<typeof Color> = () => <Color name="error-base" />;
export const ErrorDarkToken: ComponentStory<typeof Color> = () => <Color name="error-dark" />;
export const ErrorLightToken: ComponentStory<typeof Color> = () => <Color name="error-light" />;
export const Neutral25Token: ComponentStory<typeof Color> = () => <Color name="neutral-25" />;
export const Neutral50Token: ComponentStory<typeof Color> = () => <Color name="neutral-50" />;
export const Neutral75Token: ComponentStory<typeof Color> = () => <Color name="neutral-75" />;
export const Neutral85Token: ComponentStory<typeof Color> = () => <Color name="neutral-85" />;
export const Neutral95Token: ComponentStory<typeof Color> = () => <Color name="neutral-95" />;
export const NeutralBaseToken: ComponentStory<typeof Color> = () => <Color name="neutral-base" />;
export const NeutralLightToken: ComponentStory<typeof Color> = () => <Color name="neutral-light" />;
export const SuccessBaseToken: ComponentStory<typeof Color> = () => <Color name="success-base" />;
export const SuccessDarkToken: ComponentStory<typeof Color> = () => <Color name="success-dark" />;
export const SuccessLightToken: ComponentStory<typeof Color> = () => <Color name="success-light" />;
