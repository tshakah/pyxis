import { imageSnapshot } from '@storybook/addon-storyshots-puppeteer';
import initStoryshots from '@storybook/addon-storyshots';
import * as process from 'process';

process.env.STORYBOOK_ENV = 'TEST';

initStoryshots({
  test: imageSnapshot(),
  storyKindRegex: /(Test)/,
});
