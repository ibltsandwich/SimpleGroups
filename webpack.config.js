const path = require('path');
const webpack = require("webpack");
const VueLoaderPlugin = require('vue-loader/lib/plugin');

let plugins = [];
const devPlugins = [];

const prodPlugins = [
    new webpack.DefinePlugin({
        'process.env': {
            'NODE_ENV': JSON.stringify('production')
        }
    })
];

plugins = plugins.concat(
    process.env.NODE_ENV === 'production' ? prodPlugins : devPlugins
)

module.exports = {
    context: __dirname,
    entry: './frontend/application.js',
    output: {
        path: path.resolve(__dirname, 'app', 'assets', 'javascripts'),
        filename: 'bundle.js'
    },
    resolve: {
        extensions: ['*', '.js', '.vue', '.json'],
        alias: {
          'vue$': 'vue/dist/vue.esm.js'
        },
        
    },
    module: {
        rules: [
          {
            test: /\.vue$/,
            loader: 'vue-loader'
          },
          {
            test: /\.css$/,
            use: [
              'vue-style-loader',
              'css-loader'
            ]
          },
          {
            test: /\.js?$/,
            loader: 'babel-loader'
          }
        ]
      },
      
      plugins: [
        new VueLoaderPlugin(),
      ]
};