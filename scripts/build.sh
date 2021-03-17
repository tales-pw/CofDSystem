#!/usr/bin/env bash

[[ ! -d ".haxelib" ]] && sh scripts/setup.sh

rm -rf out

printf "Building Project... "
output=$(haxe build/build.hxml 2>&1)

if [[ $? -ne 0 ]] ; then
    printf "Error:\n"
    echo "$output"
    exit 1;
fi
echo "DONE!"

printf "Building Webpack JS... "
output=$(npx webpack 2>&1)
if [[ $? -ne 0 ]] ; then
    printf "Error:\n"
    echo "$output"
    exit 1;
fi
echo "DONE!"