#!/usr/bin/env sh

set -xe

for f in /usr/lib/systemd/user/gsd-*.target; do
  ln -sf $f $(basename $f)
done
