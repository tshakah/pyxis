import {resolve} from "path"
import {writeFileSync} from "fs"
import breakpoints from "../json/breakpoints.json";
import colors from "../json/colors.json";
import containers from "../json/containers.json";
import elevationColors from "../json/elevation/colors.json";
import elevationSizes from "../json/elevation/sizes.json";
import gradients from "../json/gradients.json";
import motionDuration from "../json/motion/duration.json";
import motionTiming from "../json/motion/timing.json";
import radius from "../json/radius.json";
import spacings from "../json/spacings.json";
import textSizes from "../json/typography/text/sizes.json";
import textWeights from "../json/typography/text/weights.json";
import titleSizes from "../json/typography/title/sizes.json";
import titleWeights from "../json/typography/title/weights.json";

const scssPath = resolve(__dirname, '../../', 'pyxis-scss/src/scss/tokens');

const tokens: {name: string, source: Token}[] = [
  {
    "name": "breakpoints",
    "source": breakpoints
  },
  {
    "name": "colors",
    "source": colors
  },
  {
    "name": "containers",
    "source": containers
  },
  {
    "name": "elevationColors",
    "source": elevationColors
  },
  {
    "name": "elevationSizes",
    "source": elevationSizes
  },
  {
    "name": "gradients",
    "source": gradients
  },
  {
    "name": "motionDuration",
    "source": motionDuration
  },
  {
    "name": "motionTiming",
    "source": motionTiming
  },
  {
    "name": "radius",
    "source": radius
  },
  {
    "name": "spacings",
    "source": spacings
  },
  {
    "name": "textSizes",
    "source": textSizes
  },
  {
    "name": "textWeights",
    "source": textWeights
  },
  {
    "name": "titleSizes",
    "source": titleSizes
  },
  {
    "name": "titleWeights",
    "source": titleWeights
  },
]

const appendTokenUnit = (token: Token) =>
  typeof token === 'number' ? `${token}px` : token;

const createScssMap = (name: string, tokenSource: TokenObject, child: string | null):string => {
  // First level of hierarchy
  if (!child) {
    return `$${name}: (${
      Object.keys(tokenSource).map(subchild =>
        createScssMap(name, tokenSource, subchild)
      )
    });
    `
  }

  // Second level of hierarchy
  else if(child && typeof tokenSource[child] === 'object') {
    return `
      ${child}: (${
      Object.keys(tokenSource[child]).map(subchild =>
        createScssMap(name, tokenSource[child] as TokenObject, subchild)
      )
    })
    `
  }

  // Value level
  return `${child}: ${appendTokenUnit(tokenSource[child])}`
}

const initialComment = `// DO NOT EDIT.
// This file is autogenerated by pyxis-token/scripts/generateTokens.ts
// Generated on ${new Date().toLocaleString('it-IT')}`;

const writeScssTemplate = (name:string , object: TokenObject) =>
  writeFileSync(`${scssPath}/${name}.scss`,
    `${initialComment}
    ${createScssMap(name, object, null)}`
  );

tokens.map(({name, source}) =>
  writeScssTemplate(name, source as TokenObject))

// Types
type Token = string | number | TokenObject;

interface TokenObject {
  [key: string]: Token;
}
