#!/usr/bin/env bash

[[ ! -d ".haxelib" ]] && sh scripts/setup.sh

haxe build/docs.hxml
haxelib run dox -i ./out/docs -o ./out/docs/generated
