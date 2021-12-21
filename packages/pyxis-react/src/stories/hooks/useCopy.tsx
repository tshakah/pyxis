import {useState} from "react";

const useCopy = (name:string): [boolean, () => void] => {
  const [isCopied, setIsCopied] = useState(false);

  const copyTextToClipboard = async () => {
    await navigator.clipboard.writeText(name);
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

  return [isCopied, handleCopyClick];
}

export default useCopy;