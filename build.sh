#!/bin/bash
mkdir ./build
mkdir ./build/tools/
mkdir ./build/modules/
SCAD_FILES="$(find ./ -type f -name '*.scad')"
#echo $SCAD_FILES
for file in $SCAD_FILES
do
    echo "Processing $file"

    openscad $file -o "./build/${file:2:-5}.stl"
done
