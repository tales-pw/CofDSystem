npm_publish: guard-NODE_AUTH_TOKEN build_js
	yarn version --new-version 1.0.0 --no-git-tag-version
	yarn install
	yarn publish