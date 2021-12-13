import React, { FC, useState } from 'react';
import styles from './CopyableCode.module.scss';

const CopyableCode: FC<CopyableCodeProps> = ({ text }) => {
  const [isCopied, setIsCopied] = useState(false);

  const copyTextToClipboard = async () => {
    await navigator.clipboard.writeText(text);
  };

  const handleCopyClick = () => {
    copyTextToClipboard()
      .then(() => {
        setIsCopied(true);
        setTimeout(() => {
          setIsCopied(false);
        }, 1500);
      });
  };

  return (
    <>
      <code onClick={handleCopyClick} aria-hidden="true" className={styles.wrapper}>{text}</code>
      {isCopied && <span className={styles.badge}>Copied!</span>}
    </>
  );
};

export default CopyableCode;

interface CopyableCodeProps {
  text: string;
}
