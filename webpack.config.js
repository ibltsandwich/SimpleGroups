const path = require('path');
const webpack = require("webpack");

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
    entry: './frontend/',
    output: {
        path: path.resolve(__dirname, 'app', 'assets', 'javascripts'),
        filename: 'bundle.js'
    },
    module: {
        rules: []
    },
    devtool: 'source-map',
    resolve: {
        extensions: [".js", "*"]
    }
};