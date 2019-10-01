#!/bin/bash

set -e

nimble build

cd ./bin
rm -rf *.workflow

cp -r ~/Library/Services/Tile\ Images.workflow .

if [ ! -e "ImageMagick-x86_64-apple-darwin17.7.0.tar.gz" ]; then
   curl https://imagemagick.org/download/binaries/ImageMagick-x86_64-apple-darwin17.7.0.tar.gz --output ImageMagick-x86_64-apple-darwin17.7.0.tar.gz
fi

tar fzx ImageMagick-x86_64-apple-darwin17.7.0.tar.gz

rm -rf Tile\ Images.workflow/Contents/Resources
mkdir -p Tile\ Images.workflow/Contents/Resources

cp -r ImageMagick-7.0.8 Tile\ Images.workflow/Contents/Resources
rm -rf ImageMagick-7.0.8

cp tile_images Tile\ Images.workflow/Contents/Resources

