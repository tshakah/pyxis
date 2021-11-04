import { generateAllStories, generateAllStoriesComponentMeta } from '../common';

const storyName = 'Padding Vertical';

export default generateAllStoriesComponentMeta(storyName);

generateAllStories(module, storyName, { spacingType: 'PaddingV' });
