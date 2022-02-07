import React from 'react';
import {ComponentMeta} from '@storybook/react';
import renderSourceAsHTML from "stories/utils/renderSourceAsHTML";
import Badge, {badges} from "./Badge";
import styles from "./Badge.module.scss"

export default {
  title: 'Components/Badge 🚧/All Stories',
} as ComponentMeta<typeof Badge>;

export const Default = () => <Badge />
Default.parameters = renderSourceAsHTML(Default());

export const Variants = () => (<div className={styles.wrapper}>{badges()}</div>)
Variants.parameters = renderSourceAsHTML(badges());

export const AltBackground = () => (<div className={styles.wrapper}>{badges(true)}</div>)

AltBackground.parameters = {
  backgrounds: { default: 'dark' },
  ...renderSourceAsHTML(badges(true))
};