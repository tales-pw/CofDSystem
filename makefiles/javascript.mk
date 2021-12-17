NPM_PACKAGE_ROOT=${ROOT}/out/js
NPM_PACKAGE_TEMPLATE=${ROOT}/package/js/*

build_js: setup_npm cleanup_build
	npx webpack

.ONESHELL:
npm_prepare_package: build_js
	cp -r ${NPM_PACKAGE_TEMPLATE} ${NPM_PACKAGE_ROOT}

	cd ${NPM_PACKAGE_ROOT}
	yarn version --new-version $(RELEASE_VERSION) --no-git-tag-version

.ONESHELL:
npm_publish: guard-NODE_AUTH_TOKEN build npm_prepare_package
	cd ${NPM_PACKAGE_ROOT}
	yarn publish