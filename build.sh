#!/bin/bash

set -e

nimble build

cd ./bin
rm -rf *.workflow

cp -r ~/Library/Services/Tile\ Images.workflow .

RESOURCES=Tile\ Images.workflow/Contents/Resources

rm -rf "$RESOURCES"
mkdir -p "$RESOURCES"

cp tile_images "$RESOURCES"

