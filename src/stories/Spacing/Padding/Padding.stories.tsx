import { generateAllStories, generateAllStoriesComponentMeta } from '../common';

const storyName = 'Padding';

export default generateAllStoriesComponentMeta(storyName);

generateAllStories(module, storyName, { spacingType: 'Padding' });
