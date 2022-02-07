import React from 'react';
import {ComponentMeta} from '@storybook/react';
import renderSourceAsHTML from "stories/utils/renderSourceAsHTML";
import Message, {messages} from "./Message";
import styles from "./Message.module.scss"

export default {
  title: 'Components/Message 🚧/All Stories',
} as ComponentMeta<typeof Message>;

export const Default = () => (<div className={styles.wrapper}><Message /></div>)
Default.parameters = renderSourceAsHTML(<Message />);

export const States = () => (<div className={styles.wrapper}>{messages()}</div>)
States.parameters = renderSourceAsHTML(messages());

export const WithColoredBackground = () => (<div className={styles.wrapper}>{messages(true)}</div>)
WithColoredBackground.parameters = renderSourceAsHTML(messages(true));

export const WithCloseIcon = () => <div className={styles.wrapper}><Message withClose/></div>
WithCloseIcon.parameters = renderSourceAsHTML(<Message withClose/>);

export const Ghost = () => <div className={styles.wrapper}><Message ghost/></div>
Ghost.parameters = renderSourceAsHTML(<Message ghost/>);