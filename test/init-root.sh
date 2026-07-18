#!/bin/sh

RUNDIR="$PWD"
trap 'rm -rf "$RUNDIR/tmp"' EXIT

mkdir -p tmp/test-init-root

cd / || exit
printf '  demo-project  \n  1.0.0  \n' | "$RUNDIR"/clib-init -M "$RUNDIR/tmp/test-init-root/package.json" >"$RUNDIR/tmp/test-init-root/output.txt"

if ! grep --quiet '"name": "demo-project"' "$RUNDIR/tmp/test-init-root/package.json"; then
  echo >&2 "Failed to write explicit package name in package.json from filesystem root"
  exit 1
fi

if ! grep --quiet '"version": "1.0.0"' "$RUNDIR/tmp/test-init-root/package.json"; then
  echo >&2 "Failed to write version in package.json from filesystem root"
  exit 1
fi

if grep --quiet 'package name (' "$RUNDIR/tmp/test-init-root/output.txt"; then
  echo >&2 "Unexpected path-based package name prompt from filesystem root"
  exit 1
fi
