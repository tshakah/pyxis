import { generateAllStories, generateAllStoriesComponentMeta } from '../common';

const storyName = 'Padding Horizontal';

export default generateAllStoriesComponentMeta(storyName);

generateAllStories(module, storyName, { spacingType: 'PaddingH' });
