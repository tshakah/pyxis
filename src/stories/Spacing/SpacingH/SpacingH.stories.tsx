import { generateAllStories, generateAllStoriesComponentMeta } from '../common';

const storyName = 'Spacing Horizontal';

export default generateAllStoriesComponentMeta(storyName);

generateAllStories(module, storyName, { spacingType: 'SpacingH' });
