import React from 'react';
import {ComponentMeta, ComponentStory} from '@storybook/react';
import { IconPrimaLogo } from 'components/Icon/Icons';
import { IconProps } from 'components/Icon';

export default {
  title: 'Components/Icon/All Stories',
  component: IconPrimaLogo,
  argTypes: {
    size: {
      options: ['s', 'm', 'l'],
      control: { type: 'select' },
      table: {
        category: 'Customization',
      },
    },
    boxed: {
      control: { type: 'boolean' },
      table: {
        category: 'Customization',
      },
    },
    alt: {
      control: { type: 'boolean' },
      table: {
        category: 'Customization',
      },
    },
    className: {
      control: { type: 'text' },
      table: {
        category: 'Customization',
      },
    },
    description: {
      description: 'Set an accessible description that will be read by screen readers.',
      control: { type: 'text' },
      table: {
        category: 'Accessibility',
      },
    },
  }
} as ComponentMeta<typeof IconPrimaLogo>;

const Template: ComponentStory<typeof IconPrimaLogo> = (args: IconProps) => <IconPrimaLogo {...args} />;

export const Default = Template.bind({});

export const Boxed = Template.bind({});
Boxed.args = {
  description: 'Icon description for screen reader',
  boxed: true,
};

export const BoxedAlt = Template.bind({});
BoxedAlt.args = {
  alt: true,
  description: 'Icon description for screen reader',
  boxed: true,
};

BoxedAlt.parameters = {
  backgrounds: { default: 'dark' },
};
