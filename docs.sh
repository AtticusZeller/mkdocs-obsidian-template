#!/usr/bin/env bash

# with plugins
run_uvx() {
    uvx --with mkdocs-material \
        --with mkdocs-git-revision-date-localized-plugin \
        --with mkdocs-glightbox \
        --with mkdocs-obsidian-bridge \
        --with pymdown-extensions \
        "$@"
}

get_docs_dir() {
    # Find the docs_dir from mkdocs.yaml or mkdocs.yml
    if [ -f "mkdocs.yaml" ]; then
        DOCS_DIR=$(grep -E "^docs_dir:" mkdocs.yaml | sed 's/docs_dir: *//g')
    elif [ -f "mkdocs.yml" ]; then
        DOCS_DIR=$(grep -E "^docs_dir:" mkdocs.yml | sed 's/docs_dir: *//g')
    else
        echo "Error: mkdocs.yaml or mkdocs.yml not found"
        return 1
    fi

    if [ -z "$DOCS_DIR" ]; then
        DOCS_DIR="docs"
    fi

    echo "$DOCS_DIR"
}

# Replace with your actual domain
# Ref: https://www.mkdocs.org/user-guide/deploying-your-docs/#custom-domains
# CUSTOM_DOMAIN="template.atticux.me"

# Function to setup CNAME and KaTeX
setup_files() {
    DOCS_DIR=$(get_docs_dir)
    echo "Detected docs_dir: $DOCS_DIR"

    # Create CNAME file
    # echo "Creating CNAME in $DOCS_DIR/"
    # echo $CUSTOM_DOMAIN >"$DOCS_DIR/CNAME"

    # Create js directory and katex.js
    # Ref: https://squidfunk.github.io/mkdocs-material/reference/math/#katex-docsjavascriptskatexjs
    mkdir -p "$DOCS_DIR/js"
    echo "Creating katex.js in $DOCS_DIR/js/"
    cat >"$DOCS_DIR/js/katex.js" <<'EOL'
document$.subscribe(({ body }) => {
  renderMathInElement(body, {
    delimiters: [
      { left: "$$",  right: "$$",  display: true },
      { left: "$",   right: "$",   display: false },
      { left: "\\(", right: "\\)", display: false },
      { left: "\\[", right: "\\]", display: true }
    ],
  })
})
EOL
}

# Function to clean up temporary files
cleanup_files() {
    DOCS_DIR=$(get_docs_dir)
    echo "Cleaning up temporary files in $DOCS_DIR"
    rm -f "$DOCS_DIR/CNAME"
    rm -rf "$DOCS_DIR/js/"
}

if [ "$1" == "dev" ]; then
    setup_files
    run_uvx mkdocs serve
    cleanup_files
elif [ "$1" == "deploy" ]; then
    setup_files
    run_uvx mkdocs gh-deploy --force
    cleanup_files
elif [ "$1" == "build" ]; then
    setup_files
    run_uvx mkdocs build
    cleanup_files
else
    echo "usage: $0 {dev|deploy|build}"
    exit 1
fi
