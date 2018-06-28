export default class Container
	constructor: ->
		@instances = {}
		@singletonFactories = {}
		@factories = {}

	defineGetterProperty: (alias, name)->
		if alias of this
			throw new Error("alias '#{alias}' already exists in container")

		Object.defineProperty this, alias,
			get: =>
				@get name

	defineAliases: (name)->
		aliases = [
			name
			@toCamelCase name
		]
		# we convert the array to a map to remove duplicates.
		aliases = new Set aliases
		aliases.forEach (alias)=>
			@defineGetterProperty alias, name

	toCamelCase: (str)->
		return str
			.replace /\s(.)/g, ($1)-> return $1.toUpperCase()
			.replace /[\.\-\_]([a-z])/g, ($1, $2)-> return $2.toUpperCase()
			.replace /\s/g, ''

	instance: (name, instance)->
		@instances[name] = instance
		@defineAliases name
		return @

	singleton: (name, factory)->
		@singletonFactories[name] = factory
		@defineAliases name
		return @

	value: (name, value) ->
		@instances[name] = value
		@defineAliases name
		return this

	bind: (name, factory)->
		@factories[name] = factory
		@defineAliases name
		return @

	make: (...args) ->
		@get(args...)

# construct an object instance.
	get: (name, ...args)->
# check if the instance has already been
# created as a singleton
		if (name of @instances)
			return @instances[name]

		# check if the instance is a singleton
		# and construct it.
		if (factory = @singletonFactories[name])
			object = factory.call @
			@instances[name] = object
			return object

		# check if factory function exists.
		if (factory = @factories[name])
			return factory.apply @, args

		throw new Error 'Instance not found: ' + name
