#!/bin/bash -e

rm app/assets/images/gallery/*_t.jpg

for f in app/assets/images/gallery/*.jpg
do
  echo "Creating thumbnail for $f"
  convert $f -resize 200 -quality 100 ${f//.jpg/_t.jpg}
done