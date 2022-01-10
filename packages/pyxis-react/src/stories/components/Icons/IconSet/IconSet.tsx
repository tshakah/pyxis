import React, {ChangeEventHandler, FC, useState} from 'react';
import OverviewTemplate from "stories/utils/OverviewTemplate";
import * as icons from 'components/Icon/Icons';
import {IconProps} from "components/Icon";
import Item from "./Item";
import styles from './IconSet.module.scss';

const initialList:[string, FC<IconProps>][] = Object.entries(icons);

const description = (
  <p>
    Here the entire icon set. Please note that the name above each figure is the component name of that icon.
  </p>
);

// TODO: remember to style input with proper classes once they're available
const IconSet: FC = () => {
  const [iconList, setIconList] = useState(initialList);

  const handleChange:ChangeEventHandler<HTMLInputElement> = ({ target }) => {
    const { value } = target;
    const filteredList = value.trim() === ''
      ? initialList
      : initialList.filter(
        ([name]) => name.toLowerCase().includes(value.trim().toLowerCase()),
      );
    setIconList(filteredList);
  };

  return (
    <OverviewTemplate title="Icon Set" description={description} category={"Component"} isMain>
      <div className={styles.inputWrapper}>
        <input type="text" onChange={handleChange} placeholder="Search icon..." />
      </div>
      <div className={styles.wrapper}>
        {iconList.map(
          ([name, icon]) => <Item name={name} icon={icon} key={name} />
        )}
      </div>
    </OverviewTemplate>
  );
};

export default IconSet;
