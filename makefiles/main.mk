setup_haxe:
	haxelib newrepo
	haxelib install build_scripts/_libraries_full.hxml --always

setup_npm:
	npm install

cleanup_build:
	rm -rf out

build_python: setup_haxe cleanup_build
	haxe build_scripts/build_python.hxml

build_java: setup_haxe cleanup_build
	haxe build_scripts/build_java.hxml

build_php: setup_haxe cleanup_build
	haxe build_scripts/build_php.hxml

build_js: setup_haxe setup_npm cleanup_build
	npx webpack

build: cleanup_build build_js build_python build_php build_java

docs: build
	haxe build_scripts/docs.hxml
	haxelib run dox -i ./out/docs -o ./out/docs/generated

lint: setup_haxe
	haxelib run checkstyle -s src

tests: setup_haxe
	haxe build_scripts/tests.hxml