export default {
	env: env 'ENV', 'local'
	name: env 'NAME', 'serverless-service'
	debug: env 'DEBUG', false

	secret: [
		env 'SECRET_1'
		env 'SECRET_2'
		env 'SECRET_3'
	]

	services: [
		__dirname + '/../src/provider/henk'
	]
}
