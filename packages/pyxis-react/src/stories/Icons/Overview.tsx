import React, {FC} from 'react';
import {IconAccessKey} from "../../components/Icon/Icons";
import styles from "./Icons.module.scss";

// TODO: replace with a proper doc.
const Overview: FC = () => (
  <>
      <div className={styles.wrapper}>
        <IconAccessKey size="s"/>
        <IconAccessKey size="m"/>
        <IconAccessKey size="l"/>
        <IconAccessKey size="s" isBoxed={true}/>
        <IconAccessKey size="m" isBoxed={true}/>
        <IconAccessKey size="l" isBoxed={true}/>
        <IconAccessKey size="s" isBoxed={true} alt={true}/>
        <IconAccessKey size="m" isBoxed={true} alt={true}/>
        <IconAccessKey size="l" isBoxed={true} alt={true}/>
      </div>

  </>

)

export default Overview;