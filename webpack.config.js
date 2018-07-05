const slsw = require('serverless-webpack');
const nodeExternals = require('webpack-node-externals');
const assign = require('lodash.assign');
const fsReaddirRecursive = require('fs-readdir-recursive');

function includeFiles(path) {
    return fsReaddirRecursive(path)
        .filter(
            (file) => file.match(/.*\.coffee$/)
        )
        .map((file) => {
            return {
				name: path + file.substring(0, file.length - 7),
				path: path + file,
            }
        }).reduce((list, file) => {
            list[file.name] = file.path;
            return list;
        }, {})
}

module.exports = {
	entry: assign(includeFiles('./config/'), slsw.lib.entries),
	target: 'node',
	mode: slsw.lib.webpack.isLocal ? 'development' : 'production',
	externals: [nodeExternals()],
	stats: 'minimal',
	module: {
		rules: [
			{
				loader: "coffee-loader",
                test: /\.coffee$/,
			}
		],
	},
	resolve: {
        extensions: ['.js', '.jsx', '.coffee']
    }
};
