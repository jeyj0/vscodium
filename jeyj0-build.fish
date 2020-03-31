#!/usr/bin/env fish

mkdir outputs
mkdir outputs/auto

./get_repo.sh
docker build -t vscodium .
docker run --name jeyj0-vscodium-builder vscodium:latest
docker cp jeyj0-vscodium-builder:/vscodium/VSCodium-linux-x64-.tar.gz outputs/auto/VSCodium-linux-x64.tar.gz
docker cp jeyj0-vscodium-builder:/vscodium/VSCodium-linux-x64-.tar.gz.sha256 outputs/auto/VSCodium-linux-x64.tar.gz
