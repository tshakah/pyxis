/* jshint node: true */
module.exports = {
  parameters: {
    actions: { argTypesRegex: "^on[A-Z].*" },
    controls: {
      expanded: true,
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    options: {
      storySort: {
        order: ['Introduction', 'Foundations', 'Components'],
      },
    },
  },
  options: {
    storySort: {
      order: ['Introduction', 'Foundations', 'Components'],
    },
  },
};
