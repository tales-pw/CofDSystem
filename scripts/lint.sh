#!/usr/bin/env bash

[[ ! -d ".haxelib" ]] && sh scripts/setup.sh

haxelib run checkstyle -s src