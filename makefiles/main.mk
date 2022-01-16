SOURCE_ARGS=-s src -s test

ensure_haxe_repo:
	haxelib newrepo

setup_haxe: ensure_haxe_repo
	haxelib install build_scripts/_libraries_full.hxml --always
	haxelib git thx.core https://github.com/fponticelli/thx.core.git 82aa5db46e1c2d2b7d45cb6570687d5d357c21bd

setup_npm:
	npm install

setup_checkstyle: ensure_haxe_repo
	haxelib install checkstyle 2.7.0

setup_formatter: ensure_haxe_repo
	haxelib install formatter 1.12.0

cleanup_build:
	rm -rf out

build_%: setup_haxe cleanup_build
	haxe build_scripts/$@.hxml

build_all: setup_haxe
	haxe build_scripts/build.hxml

build_docs: cleanup_build
	haxe build_scripts/docs.hxml
	haxelib run dox -i ./out/docs -o ./out/docs/generated

build: cleanup_build build_all build_js

checkstyle_check: setup_checkstyle
	haxelib run checkstyle ${SOURCE_ARGS} --exitcode

formatter_check: setup_formatter
	haxelib run formatter --check ${SOURCE_ARGS}

lint: checkstyle_check formatter_check

reformat: setup_formatter
	haxelib run formatter ${SOURCE_ARGS}

tests: setup_haxe
	haxe build_scripts/tests.hxml