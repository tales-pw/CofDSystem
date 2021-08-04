SOURCE_ARGS=-s src -s test

ensure_haxe_repo:
	haxelib newrepo

setup_haxe: ensure_haxe_repo
	haxelib install build_scripts/_libraries_full.hxml --always

setup_npm:
	npm install

setup: setup_haxe setup_npm

setup_checkstyle: ensure_haxe_repo
	haxelib install checkstyle 2.7.0

setup_formatter: ensure_haxe_repo
	haxelib install formatter 1.12.0

cleanup_build:
	rm -rf out

build: setup cleanup_build
	npx webpack
	haxe build_scripts/build.hxml

docs: build
	haxe build_scripts/docs.hxml
	haxelib run dox -i ./out/docs -o ./out/docs/generated

checkstyle_check: setup_checkstyle
	haxelib run checkstyle ${SOURCE_ARGS}

formatter_check: setup_formatter
	haxelib run formatter --check ${SOURCE_ARGS}

lint: checkstyle_check formatter_check

reformat: setup_formatter
	haxelib run formatter ${SOURCE_ARGS}

tests: setup_haxe
	haxe build_scripts/tests.hxml