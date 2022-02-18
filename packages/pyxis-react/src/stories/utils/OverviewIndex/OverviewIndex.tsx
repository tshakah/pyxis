import React, {FC} from "react";
import {pascalToKebab} from 'commons/utils/string';

const OverviewIndex: FC<OverviewIndexProps> = ({titles}) =>
  <ul className="list">
    {titles.map(
      (title) => <li className="list__item" key={title}>
        <a href={`#${pascalToKebab(title)}`} target="_self" className="link">{title}</a>
      </li>
    )}
  </ul>

interface OverviewIndexProps {
  titles: string[]
}

export default OverviewIndex