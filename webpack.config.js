
const slsw = require('serverless-webpack');
const nodeExternals = require('webpack-node-externals');

module.exports = {
	entry: slsw.lib.entries,
	target: 'node',
	mode: slsw.lib.webpack.isLocal ? 'development' : 'production',
	externals: [nodeExternals()],
	stats: 'minimal',
	module: {
		rules: [
			{
				loader: "coffee-loader",
                test: /\.coffee$/,
				options: {
                    transpile: {
                        plugins: ['transform-node-env-inline'],
                        presets: ['env']
                    }
                }
			}
		],
	},
	resolve: {
        extensions: ['.js', '.jsx', '.coffee']
    }
};
