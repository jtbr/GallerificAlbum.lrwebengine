#!/bin/bash
# Sync the latest release files from the Mercurial development repos into this
# git release repo. Development and testing happen in hg; this repo is the
# public mirror that releases are built from.
#
# Gallerific lives in TWO hg repos: the plug-in engine and the templates.
#
# Usage:
#   ./sync-from-hg.sh [path-to-GallerificAlbum.lrwebengine] [path-to-Gallerific-Templates]
#
# Defaults are the in-tree locations relative to this repo. After running,
# review with `git status`, then commit (the script prints the source hg
# revisions to cite) and, when releasing, run ./build-release.sh and attach the
# zip to a GitHub Release.
#
# Requires: hg, rsync.
set -e
cd "$(dirname "$0")"
HG_PLUGIN="${1:-../Web Galleries/GallerificAlbum.lrwebengine}"
HG_TEMPLATES="${2:-../Web Templates/Gallerific-Templates}"

for d in "$HG_PLUGIN" "$HG_TEMPLATES"; do
  if [ ! -d "$d/.hg" ]; then
    echo "Error: '$d' is not a Mercurial repo (no .hg). Pass paths as arguments." >&2
    exit 1
  fi
done

PLUGIN_ID=$(hg --cwd "$HG_PLUGIN" id -i)
TPL_ID=$(hg --cwd "$HG_TEMPLATES" id -i)
echo "Syncing plug-in from $HG_PLUGIN (hg $PLUGIN_ID)"
echo "Syncing templates from $HG_TEMPLATES (hg $TPL_ID)"

# 1. The installable plug-in folder. --delete mirrors deletions; exclude
#    dev/internal/generated files, the markdown source, the root license, the
#    authoring-only JustStrings companions, background source art, and hg cruft.
rsync -a --delete \
  --exclude='.hg/' --exclude='.hgignore' --exclude='.hgtags' \
  --exclude='backup/' --exclude='*.orig' --exclude='TODO.txt' \
  --exclude='README.html' --exclude='readme.md' --exclude='license.txt' \
  --exclude='JustStrings*' \
  --exclude='res/deploy_images.sh' --exclude='res/deploy_panoramas.txt' \
  --exclude='res/backgrounds/*.psd' --exclude='res/backgrounds/ornaments_texture1129/' --exclude='res/backgrounds/*.txt' \
  --exclude='res/icons/rename.sh' --exclude='res/icons/00NOTE.txt' --exclude='res/icons/preview.html' \
  --exclude='.DS_Store' --exclude='Thumbs.db' --exclude='*~' --exclude='.vscode/' \
  "$HG_PLUGIN/" "GallerificAlbum.lrwebengine/"

# 2. The template skins. Exclude hg metadata, the previews source folder, and
#    the author's personal "My RTW" preset.
rsync -a --delete \
  --exclude='.hg/' --exclude='.hgignore' --exclude='previews/' \
  --exclude='My RTW - Gallerific.lrtemplate' \
  --exclude='.DS_Store' --exclude='Thumbs.db' \
  "$HG_TEMPLATES/" "Gallerific-Templates/"

# 3. Root-level files: the readme source and the license.
cp "$HG_PLUGIN/readme.md" "readme.md"
cp "$HG_PLUGIN/license.txt" "license.txt"

echo
echo "Done. Synced plug-in hg $PLUGIN_ID, templates hg $TPL_ID."
echo "Next: review 'git status', then e.g.:"
echo "  git add -A && git commit -m \"Sync from hg (plugin $PLUGIN_ID, templates $TPL_ID)\""
echo "  ./build-release.sh   # then attach GallerificAlbum.lrwebengine.zip to a GitHub Release"
