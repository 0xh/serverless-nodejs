import Joi from 'joi'
import Provider from '../core/provider'

export default class Home extends Provider
	fields:
		params:
			id: Joi.string()

	handle: (ctx) ->
		@fields

		data = {
			meta: {
				title: 'Homepage'
				description: 'Homepage'
			}
		}

		await ctx.render 'pages/home', data


Home.fields

