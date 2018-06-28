import Trait from '../trait'

export default class Web extends Trait
	route: (method, path, action) ->
		console.log this, @container, @provider
		router = @container.get 'router'

		router[method].call router, path

	routes: (configFunc) ->
		await configFunc.apply(this)

	get: (path, action)->
		@route 'get', path, action

	post: (path, action)->
		@route 'post', path, action

	put: (path, action)->
		@route 'put', path, action

	delete: (path, action)->
		@route 'delete', path, action
