import React from 'react';
import {ComponentMeta, ComponentStory} from '@storybook/react';
import Button from 'components/Button';
import {ButtonFC} from "components/Button/types";
import {IconPen} from "components/Icon/Icons";

const table =  { category: 'Customization' };

export default {
  title: 'Components/Button/All Stories',
  argTypes: {
    variant: {
      options: ['primary', 'secondary', 'tertiary', 'brand', 'ghost'],
      control: {
        type: 'select'
      },
      table
    },
    size: {
      options: ['small', 'medium', 'large', 'huge'],
      control: {
        type: 'select'
      },
      table
    },
    loading: {
      control: {
        type: 'boolean'
      },
      table
    },
    shadow: {
      control: {
        type: 'boolean'
      },
      table
    },
    contentWidth: {
      control: {
        type: 'boolean'
      },
      table
    },
    iconPlacement: {
      options: ['leading', 'trailing', 'only'],
      control: {
        type: 'select'
      },
      table
    },
    alt: {
      control: {
        type: 'boolean'
      },
      table
    },
    dataTestId: {
      table: { disable: true }
    },
    icon: {
      table: { disable: true }
    }
  }
} as ComponentMeta<typeof Button>;

const Template: ComponentStory<ButtonFC> = args => <Button {...args}>Text</Button>

export const Primary = Template.bind({});
Primary.args = {
  variant: "primary",
};

export const Secondary = Template.bind({});
Secondary.args = {
  variant: "secondary"
};

export const Tertiary = Template.bind({});
Tertiary.args = {
  variant: "tertiary"
};

export const Brand = Template.bind({});
Brand.args = {
  variant: "brand"
};

export const Ghost = Template.bind({});
Ghost.args = {
  variant: "ghost"
};

export const Icon = Template.bind({});
Icon.args = {
  variant: "primary",
  icon: IconPen
};

export const IconOnly = Template.bind({});
IconOnly.args = {
  variant: "primary",
  children: "Accessible description",
  iconPlacement: "only",
  icon: IconPen
};

export const WithShadow = Template.bind({});
WithShadow.args = {
  shadow: true
};

export const Loading = Template.bind({});
Loading.args = {
  loading: true
};

export const ContentWidth = Template.bind({});
ContentWidth.args = {
  contentWidth: true
};

export const AltBackground = Template.bind({});
AltBackground.args = {
  alt: true
};

AltBackground.parameters = {
  backgrounds: { default: 'dark' },
};