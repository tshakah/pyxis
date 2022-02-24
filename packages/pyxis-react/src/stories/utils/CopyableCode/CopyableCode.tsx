import React, {FC} from 'react';
import styles from './CopyableCode.module.scss';
import useCopy from "stories/hooks/useCopy";

const CopyableCode: FC<CopyableCodeProps> = ({ text }) => {
  const [isCopied, handleCopyClick] = useCopy(text);

  return (
    <>
      <code onClick={handleCopyClick} aria-hidden="true" className={styles.wrapper}>
        {text}
        {isCopied && <span className={styles.badge}>Copied!</span>}
      </code>
    </>
  );
};

export default CopyableCode;

interface CopyableCodeProps {
  text: string;
}
