npm_publish: guard-NODE_AUTH_TOKEN build
	echo $(NODE_AUTH_TOKEN)
	yarn version --new-version 1.0.0 --no-git-tag-version
	yarn publish