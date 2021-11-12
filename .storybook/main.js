/* jshint node: true */
module.exports = {
  stories: process.env.STORYBOOK_ENV === 'TEST'
    ? ["../src/**/Test.stories.@(ts|tsx|mdx)"]
    : ["../src/**/!(Test).stories.@(ts|tsx|mdx)"],
  addons: [
    "@storybook/addon-a11y",
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    "@storybook/preset-create-react-app",
  ],
};
