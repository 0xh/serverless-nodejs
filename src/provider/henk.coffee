import WebAction from '../core/web-action'

export default class Henk extends WebAction
	routes: ->
		@get '/', 'action.home'

