import { FC, ReactNode } from 'react';
import logo from 'stories/assets/logo.svg';
import styles from './OverviewTemplate.module.scss';

const OverviewTemplate: FC<AllStoriesOverviewGeneratorProps> = (
  {
    title,
    description,
    category,
    children,
  },
) => (
  <>
    <header className={styles.headerWrapper}>
      <div className={styles.logo}>
        <img src={logo} alt="" height="20" />
      </div>
      <div className={styles.content}>
        <div className={styles.category}>{category}</div>
        <h2 className={styles.title}>{title}</h2>
      </div>
    </header>

    <div className={styles.description}>
      {description}
    </div>

    {children}
  </>
);

export default OverviewTemplate;

interface AllStoriesOverviewGeneratorProps {
  category: string,
  description: ReactNode,
  title: string,
}
