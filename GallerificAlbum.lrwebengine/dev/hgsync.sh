#!/bin/bash
# Reliable Linux <-> Windows hg sync via bundle files.
#
# Why: the two repos are only connected through a VM shared folder. Running hg
# pull/push *directly* over the share corrupts/garbles the revlog store (shared
# folders lack the cache-coherency and mmap semantics hg's store needs). A single
# bundle file, by contrast, copies across the share fine, and each hg operation
# then runs locally on its own native disk.
#
# Run on the Linux side, from anywhere inside this repo:
#   ./dev/hgsync.sh out [bundlefile]   # write a full bundle for Windows to grab
#   ./dev/hgsync.sh in  <bundlefile>   # ingest a bundle that Windows produced
#
# On Windows (operating on the VM's C: drive, NOT the share):
#   1. copy the bundle from the share to C: first, then locally:
#        hg pull  C:\path\to\bundle.hg  &&  hg update     # into an existing clone
#        hg clone C:\path\to\bundle.hg  FullpageAlbum     # for a fresh clone
#   2. to send Windows commits back: hg bundle --all C:\out.hg, copy it onto the
#      share, then run './dev/hgsync.sh in <that file>' here on Linux.
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
case "$1" in
  out)
    OUT="${2:-../fullpage-sync.hg}"
    hg bundle --all "$OUT"
    echo "Wrote full bundle: $OUT"
    echo "On Windows: copy it to C:, then 'hg pull <copy>' (or 'hg clone <copy>') locally." ;;
  in)
    [ -f "$2" ] || { echo "Usage: hgsync.sh in <bundlefile>" >&2; exit 1; }
    hg pull "$2"
    echo "Pulled $2. Run 'hg update' to move the working dir to tip." ;;
  *)
    echo "Usage: hgsync.sh out [bundlefile] | in <bundlefile>" >&2; exit 1 ;;
esac
