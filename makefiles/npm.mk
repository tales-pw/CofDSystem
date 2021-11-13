NPM_PACKAGE_ROOT=./out/js
NPM_PACKAGE_TEMPLATE=template-package.json
NPM_PACKAGE_CONFIG=${NPM_PACKAGE_ROOT}/package.json

.ONESHELL:
npm_prepare_package: build_js
	cp ${NPM_PACKAGE_TEMPLATE} ${NPM_PACKAGE_CONFIG}

	cd ${NPM_PACKAGE_ROOT}
	
	yarn version --new-version $(RELEASE_VERSION) --no-git-tag-version

.ONESHELL:
npm_publish: guard-NODE_AUTH_TOKEN build npm_prepare_package
	cd ${NPM_PACKAGE_ROOT}
	yarn publish