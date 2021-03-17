const path = require('path');

module.exports = {
  mode: 'development',
  devtool: 'source-map',
  entry: './build/webpack.hxml',
  output: {
    filename: 'CofDSystem.js',
    path: path.resolve(__dirname, 'out/js'),
    library: 'CofDSystem',
    libraryTarget: 'this',
    globalObject: "typeof self !== 'undefined' ? self : this"
  },
  module: {
    rules: [
      // all files with hxml extension will be handled by `haxe-loader`
      {
        test: /\.hxml$/,
        loader: 'haxe-loader',
        options: {
          debug: true
        }
      }
    ]
  }
}