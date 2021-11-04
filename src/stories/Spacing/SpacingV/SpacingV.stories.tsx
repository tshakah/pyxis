import { generateAllStories, generateAllStoriesComponentMeta } from '../common';

const storyName = 'Spacing Vertical';

export default generateAllStoriesComponentMeta(storyName);

generateAllStories(module, storyName, { spacingType: 'SpacingV' });
