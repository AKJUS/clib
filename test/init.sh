#!/bin/sh

RUNDIR="$PWD"
trap 'rm -rf "$RUNDIR/tmp"' EXIT

mkdir -p tmp/test-init

cd tmp/test-init || exit
printf '  demo-project  \n  2.4.6  \n' | ../../clib-init -M package.json >/dev/null
cd - >/dev/null || exit

if ! grep --quiet '"name": "demo-project"' tmp/test-init/package.json; then
  echo >&2 "Failed to write trimmed package name in package.json"
  exit 1
fi

if ! grep --quiet '"version": "2.4.6"' tmp/test-init/package.json; then
  echo >&2 "Failed to write trimmed version in package.json"
  exit 1
fi
