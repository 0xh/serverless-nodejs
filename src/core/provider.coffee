export default class Provider
	use: []

	constructor: (@container)->
		@singleton = @container.singleton.bind @container
		@instance = @container.instance.bind @container
		@get = @container.get.bind @container

		# properties
		@debug = @container.config.app.debug
		@env = @container.config.app.env

		for trait in @use
			@addTrait trait


	traits: {}
	register: ->
	boot: ->

	addTrait: (traitDef) ->
		trait = traitDef.get this, @container

		console.log trait

		@traits[trait.symbol] = trait

		for [key, value] in Object.entries(trait.exports)
			if key of this
				if 'trait' in this[key]
					err = "#{key} is already defined in Provider(#{@constructor.name}) by Trait(#{@traits[this[key].trait].name})"
				else
					err = "#{key} is already defined by Provider(#{@constructor.name})"

				throw new Error(
					"While exporting properties of Trait(#{trait.name}) encountered error: #{err}"
				)


			Object.defineProperty this, key, {
				value
			}

