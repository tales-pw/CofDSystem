npm_publish: guard-PACKAGES_TOKEN build
	yarn version --new-version dev --no-git-tag-version
	yarn
	yarn publish