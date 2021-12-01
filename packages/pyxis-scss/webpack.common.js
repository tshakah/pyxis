const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const StylelintPlugin = require("stylelint-webpack-plugin");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");

const stylelintOptions = {
  configFile: ".stylelintrc",
  context: "scss",
  emitError: true,
  emitWarning: true,
  failOnWarning: true,
  ignoreDisables: true,
  syntax: "scss",
};

const sassOptions = {
  implementation: require("sass"),
  sassOptions: {
    outputStyle: "compressed",
    sourceMap: false,
  },
};

module.exports = {
  context: path.resolve(__dirname, "src"),
  entry: {
    pyxis: "./pyxis.js"
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    publicPath: "/",
    filename: "[name].js",
  },
  mode: 'development',
  module: {
    rules: [
      {
        test: /\.(sa|sc|c)ss$/,
        include: path.resolve(__dirname, "src", "scss"),
        use: [
          { loader: MiniCssExtractPlugin.loader },
          { loader: "css-loader" },
          { loader: "postcss-loader" },
          { loader: "sass-loader", options: sassOptions },
        ],
      },
      {
        test: /\.(jpe?g|svg|png|gif|ico|eot|ttf|woff2?)(\?v=\d+\.\d+\.\d+)?$/i,
        type: "asset/resource",
      },
    ],
  },
  plugins: [
      new CleanWebpackPlugin(), 
      new MiniCssExtractPlugin(), 
      new StylelintPlugin(stylelintOptions)
  ],
  devServer: {
    static: {
      directory: path.join(__dirname, "./"),
    },
    compress: true,
    port: 8080,
  }
};
