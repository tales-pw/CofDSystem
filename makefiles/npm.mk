npm_publish: guard-NODE_AUTH_TOKEN build
	yarn version --new-version $(RELEASE_VERSION) --no-git-tag-version
	yarn publish