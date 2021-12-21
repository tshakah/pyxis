/* jshint node: true */
const {sortStories} = require("./sortStories");

module.exports = {
  parameters: {
    actions: { argTypesRegex: "^on[A-Z].*" },
    backgrounds: { values: [
        { name: 'light', value: '#ffffff' },
        { name: 'dark', value: '#21283b' },
      ]
    },
    controls: {
      expanded: true,
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    options: {
      storySort: sortStories(
        [
          ['Introduction', 'Foundations', 'Components'], // 1. level
          ['...'], // 2. level
          ['Overview', '...', 'All Stories'] // 3. level
        ]
      ),
    },
  },
};
