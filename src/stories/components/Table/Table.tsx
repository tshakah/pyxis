import React, { FC } from 'react';
import shortid from 'shortid';
import Row, { TableRow } from './Row';
import styles from './Table.module.scss';

const Table: FC<TableProps> = ({ head, body, gridTemplateColumns = '' }) => (
  <div className={styles.wrapper}>
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
}

type TableHead = string[];
