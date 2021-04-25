setup_haxe:
	haxelib newrepo
	haxelib install build_scripts/_libraries_full.hxml --always

setup_npm:
	npm install

setup: setup_haxe setup_npm

cleanup_build:
	rm -rf out

build: setup cleanup_build
	npx webpack
	haxe build_scripts/build.hxml

docs: build
	haxe build_scripts/docs.hxml
	haxelib run dox -i ./out/docs -o ./out/docs/generated

lint: setup_haxe
	haxelib run checkstyle -s src

tests: setup_haxe
	haxe build_scripts/tests.hxml