#!/bin/bash

set -x

# Get the machine architecture
ARCH=$(uname -m)

# Map the architecture to Docker's expected format
case "$ARCH" in
    x86_64)
        CHEZMOI_ARCH="amd64"
        ;;
    aarch64)
        CHEZMOI_ARCH="aarch64"
        ;;
    armv7l)
        CHEZMOI_ARCH="armhfp"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

docker build --build-arg CHEZMOI_ARCH=$CHEZMOI_ARCH -t dotfile-tester .
