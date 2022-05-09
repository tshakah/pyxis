module.exports = {
  plugins: [
    require('autoprefixer'),
    require('postcss-selector-not').default,
    require('cssnano'),
  ]
}
