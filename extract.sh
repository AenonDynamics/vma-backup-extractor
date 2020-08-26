#!/usr/bin/env bash

set -e

docker build \
    -t vma-image-extractor \
    .

docker run \
    --tty \
    --interactive \
    --mount type=bind,source="$(pwd)"/backup,target=/mnt/backup,readonly \
    --mount type=bind,source="$(pwd)"/output,target=/mnt/output \
    vma-image-extractor \
    $@