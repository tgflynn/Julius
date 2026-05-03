#!/bin/sh

PROJ_DIR="${HOME}/projects/lisp/projects/julius"
CACHE_DIR="${HOME}/.cache/common-lisp/sbcl-2.6.3-linux-x64/home/flynn/projects/lisp/projects/julius"

find "${CACHE_DIR}" -iname '*.fasl' -exec rm '{}' ';'
find "${PROJ_DIR}" -iname '*.fasl' -exec rm '{}' ';'
