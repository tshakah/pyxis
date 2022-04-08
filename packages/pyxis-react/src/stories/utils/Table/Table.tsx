import React, { FC } from 'react';
import shortid from 'shortid';
import Row, { TableRow } from './Row';
import styles from './Table.module.scss';
import classNames from "classnames";

const Table: FC<TableProps> = ({ head, body, gridTemplateColumns = '', size = 'large'}) => (
  <div className={classNames(styles.wrapper, {[styles.wrapperSmall]: size === 'small'})}>
    <div className={styles.head} style={{ gridTemplateColumns }}>
      {head.map((title) => (
        <div className={styles.title} key={title}>{title}</div>
      ))}
    </div>
    {body.map((row) => (
      <Row gridTemplateColumns={gridTemplateColumns} key={shortid.generate()}>
        {row}
      </Row>
    ))}
  </div>
);

export default Table;

interface TableProps {
  head: TableHead,
  body: TableRow[],
  gridTemplateColumns?: string,
  size?: 'small' | 'large',
}

type TableHead = string[];
