import { imageSnapshot } from '@storybook/addon-storyshots-puppeteer';
import initStoryshots from '@storybook/addon-storyshots';

initStoryshots({ test: imageSnapshot() });
