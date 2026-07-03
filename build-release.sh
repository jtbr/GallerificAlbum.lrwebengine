#!/bin/bash
# Build the installable Gallerific release zip.
#
# Generates README.html from readme.md (the GitHub-facing markdown source) with
# pandoc, then packages the GallerificAlbum.lrwebengine plug-in folder, the
# Gallerific-Templates skins, and README.html + license.txt at the top level
# (the classic Lightroom web-gallery release layout). Build tooling and git
# metadata are not included.
#
# Requires: pandoc, zip.
#
# Upload the result as a GitHub Release asset named GallerificAlbum.lrwebengine.zip.
set -e
cd "$(dirname "$0")"

# 1. Generate the in-package README.html from readme.md.
pandoc readme.md -f gfm -t html5 --template readme-template.html \
  --metadata pagetitle="Gallerific HTML5 Lightroom Web Album" \
  -o README.html

# 2. Package the release: plug-in folder + templates + README.html + license.txt.
OUT="GallerificLightroomWebAlbum.zip"
rm -f "$OUT"
zip -r "$OUT" GallerificAlbum.lrwebengine Gallerific-Templates README.html license.txt \
  -x '*/.DS_Store' '*/Thumbs.db' \
  'GallerificAlbum.lrwebengine/dev' \
  'GallerificAlbum.lrwebengine/res/backgrounds/bw_*' \
  'GallerificAlbum.lrwebengine/res/backgrounds/rough_*' \
  'GallerificAlbum.lrwebengine/res/backgrounds/transparent_*' \
  'GallerificAlbum.lrwebengine/res/backgrounds/*_@2X*' \
  'GallerificAlbum.lrwebengine/res/backgrounds/index.html'
echo "Built $OUT"
