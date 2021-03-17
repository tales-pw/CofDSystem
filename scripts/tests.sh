#!/usr/bin/env bash

[[ ! -d ".haxelib" ]] && sh scripts/setup.sh

haxe build/tests.hxml