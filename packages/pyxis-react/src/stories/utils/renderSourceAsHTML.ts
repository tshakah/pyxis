import React from "react";
import prettier from "prettier";
import {decode} from "html-entities";
import {renderToStaticMarkup} from "react-dom/server";
import HTMLParser from "prettier/parser-html";

const renderToHTML = (element:React.ReactElement):string =>
  prettier.format(
    decode(renderToStaticMarkup(element).replaceAll(/aria-[a-z]+=""|=""/g, '')),
    {
      parser: 'html',
      plugins: [HTMLParser],
      htmlWhitespaceSensitivity: 'ignore',
      printWidth: 100
    }
  );

const renderSourceAsHTML = (element:React.ReactElement) => ({
  docs: {
    source: {
      code: renderToHTML(element)
    }
  }
})

export default renderSourceAsHTML;