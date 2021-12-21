import React from 'react';
import {ComponentMeta, ComponentStory} from '@storybook/react';
import {IconPrimaLogo} from 'components/Icon/Icons';
import {IconProps} from 'components/Icon/Icon';

export default {
  title: 'Components/Icon/All Stories',
  component: IconPrimaLogo,
  argTypes: {
    size: {
      defaultValue: 'm',
      options: ['s', 'm', 'l'],
      control: { type: 'select' },
      table: {
        category: 'Customization',
        defaultValue: { summary: 'm' },
      },
    },
    isBoxed: {
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
Default.args = {
  alt: false,
  description: 'Icon description for screen reader',
  isBoxed: false,
};

export const Boxed = Template.bind({});
Boxed.args = {
  alt: false,
  description: 'Icon description for screen reader',
  isBoxed: true,
};

export const BoxedAlt = Template.bind({});
BoxedAlt.args = {
  alt: true,
  description: 'Icon description for screen reader',
  isBoxed: true,
};

BoxedAlt.parameters = {
  backgrounds: { default: 'dark' },
};
