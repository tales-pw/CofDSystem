npm_publish: guard-PACKAGES_TOKEN build
	yarn
	yarn version --new-version $(RELEASE_VERSION) --no-git-tag-version
	yarn publish