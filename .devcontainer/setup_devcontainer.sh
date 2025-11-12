#!/bin/bash

# Source and destination
BASE_DIR="$HOME/.devcontainer"
DEST_DIR="$(pwd)/.devcontainer"

mkdir -p "$DEST_DIR"

cp "$BASE_DIR/devcontainer-base.json" "$DEST_DIR/devcontainer.json"
cp "$BASE_DIR/Dockerfile" "$DEST_DIR/Dockerfile"
cp "$BASE_DIR/docker-compose.yml" "$DEST_DIR/docker-compose.yml"

echo "Base devcontainer files copied to $DEST_DIR"
