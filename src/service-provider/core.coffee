
import Joi 				from 'joi'
import Validator 		from '../core/validator'
import ServiceProvider	from '../core/service-provider'

export default class Core extends ServiceProvider

	register: ->

		@singleton 'validator', ->
			return new Validator Joi
