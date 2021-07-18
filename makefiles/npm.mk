npm_publish: guard-NODE_AUTH_TOKEN build
	yarn version --new-version 1.0.0a1 --no-git-tag-version
	yarn publish