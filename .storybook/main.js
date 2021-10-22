/* jshint node: true */
module.exports = {
  stories: ["../src/**/*.stories.mdx", "../src/**/*.stories.@(ts|tsx)"],
  addons: [
    "@storybook/addon-a11y",
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    "@storybook/preset-create-react-app",
  ],
};
