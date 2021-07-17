npm_publish: guard-NODE_AUTH_TOKEN build
	yarn version --new-version dev --no-git-tag-version
	yarn
	yarn publish