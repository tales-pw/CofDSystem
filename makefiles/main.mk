setup_haxe:
	haxelib newrepo
	haxelib install build/_libraries_full.hxml --always

setup_npm:
	npm install

setup: setup_haxe setup_npm

cleanup_build:
	rm -rf out

build: setup cleanup_build
	npx webpack
	haxe build/build.hxml

docs: build
	haxe build/docs.hxml
	haxelib run dox -i ./out/docs -o ./out/docs/generated

lint: setup_haxe
	haxelib run checkstyle -s src

tests: setup
	haxe build/tests.hxml