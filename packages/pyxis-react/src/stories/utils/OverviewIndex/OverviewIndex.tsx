import React, {FC} from "react";
import {pascalToKebab} from 'commons/utils/string';
import styles from './OverviewIndex.module.scss';

const OverviewIndex: FC<OverviewIndexProps> = ({titles}) =>
  <ul className={styles.wrapper}>
    {titles.map(
      (title) => <li className={styles.item}>
        <a href={`#${pascalToKebab(title)}`} target="_self" className={styles.link}>{title}</a>
      </li>
    )}
  </ul>

interface OverviewIndexProps {
  titles: string[]
}

export default OverviewIndex