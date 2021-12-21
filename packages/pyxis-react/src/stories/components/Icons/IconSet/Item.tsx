import React, {FC} from "react";
import useCopy from "stories/hooks/useCopy";
import classNames from "classnames";
import styles from "./IconSet.module.scss";
import {IconProps} from "components/Icon/Icon";

const Item: FC<ItemProp> = ({name, icon: Icon}) => {
  const [isCopied, handleCopyClick] = useCopy(name);

  return (
    <div
      className={classNames(styles.item, {[styles.copied]: isCopied})}
      onClick={handleCopyClick}
    >
      <Icon size="l" />
      {name}
    </div>
  );
}

interface ItemProp {
  name: string,
  icon: FC<IconProps>
}

export default Item;