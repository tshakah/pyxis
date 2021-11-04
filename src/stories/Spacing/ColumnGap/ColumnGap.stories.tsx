import { generateAllStories, generateAllStoriesComponentMeta } from '../common';

const storyName = 'Column Gap';

export default generateAllStoriesComponentMeta(storyName);

generateAllStories(module, storyName, { spacingType: 'ColumnGap' });
