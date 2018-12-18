const path = require('path')

module.exports = {
  entry: './frontend/index.js',
  output: {
    path: path.join(__dirname, 'app/assets/javascripts/webpack'),
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
            presets: ['es2015', 'react']
        }
      }
    ]
  }
}
