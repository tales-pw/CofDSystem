npm_publish: guard-NODE_AUTH_TOKEN build_js
	npm version 1.0.0
	npm lock
	npm publish