module.exports = {
  entry: "./frontend/main.jsx",
  output: {
      path: "./",
      filename: "bundle.js"
  },
  module: {
    loaders: [
      {
        test: [/\.jsx?$/, /\.js?$/],
        exclude: /(node_modules)/,
        loader: 'babel',
        query: {
          presets: ['es2015', 'react']
        }
      }
    ]
  },
  devtool: 'source-map',
  resolve: {
        extensions: ['', '.js', '.jsx']
    }
};
