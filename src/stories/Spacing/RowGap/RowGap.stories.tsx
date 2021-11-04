import { generateAllStories, generateAllStoriesComponentMeta } from '../common';

const storyName = 'Row Gap';

export default generateAllStoriesComponentMeta(storyName);

generateAllStories(module, storyName, { spacingType: 'RowGap' });
