import Provider from './provider'
import Web from './provider/trait/web'

export default class WebAction extends Provider
	use: [Web.use({'routes': 'routeConfig'})]

	boot: ->
		@routeConfig @routes
	routes: ->
	register: ->
		@define 'route', '???'
