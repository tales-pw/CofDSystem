#!/usr/bin/env bash

echo "Setting up haxe deps:"
haxelib newrepo
haxelib install build/_libraries_full.hxml

printf "\n"

echo "Setting up npm deps:"
npm install