#!/usr/bin/env bash

# with plugins
run_uvx() {
    uvx --with mkdocs-material \
        --with mkdocs-git-revision-date-localized-plugin \
        --with mkdocs-glightbox \
        --with mkdocs-obsidian-bridge \
        --with mkdocs-publisher \
        --with pymdown-extensions \
        "$@"
}

if [ "$1" == "dev" ]; then
    run_uvx mkdocs serve
elif [ "$1" == "deploy" ]; then
    run_uvx mkdocs gh-deploy --force
elif [ "$1" == "build" ]; then
    run_uvx mkdocs build
else
    echo "usage: $0 {dev|deploy}"
    exit 1
fi
