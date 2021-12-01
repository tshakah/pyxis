import React, { FC, ReactNode } from 'react';
import styles from './OverviewTemplate.module.scss';

const OverviewTemplate: FC<AllStoriesOverviewGeneratorProps> = (
  {
    title,
    description,
    category,
    children,
    isMain,
  },
) => (
  <>
    <div className={styles.header}>
      {category && isMain && <div className={styles.category}>{category}</div>}
      <h2 className={isMain ? styles.mainTitle : styles.title}>{title}</h2>
    </div>

    <div className={styles.description}>
      {description}
    </div>

    {children}
  </>
);

export default OverviewTemplate;

interface AllStoriesOverviewGeneratorProps {
  description: ReactNode,
  title: string,
  category?: string,
  isMain?: boolean,
}
