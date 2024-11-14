#!/bin/sh

# force go modules
export GOPATH=""

# disable cgo
export CGO_ENABLED=0

# force linux amd64 platform
export GOOS=linux
export GOARCH=amd64

set -e
set -x

# build the binary
GOOS=linux GOARCH=amd64 go build -o release/linux/amd64/buidlah-gcr    ./cmd/buildah-gcr
GOOS=linux GOARCH=amd64 go build -o release/linux/amd64/buidlah-ecr    ./cmd/buildah-ecr
GOOS=linux GOARCH=amd64 go build -o release/linux/amd64/buidlah-docker ./cmd/buildah-docker
GOOS=linux GOARCH=amd64 go build -o release/linux/amd64/buidlah-acr    ./cmd/buildah-acr
GOOS=linux GOARCH=amd64 go build -o release/linux/amd64/buidlah-heroku   ./cmd/buildah-heroku

# build the docker image
docker build -f docker/gcr/Dockerfile.linux.amd64    -t ymage/buildah-gcr .
docker build -f docker/ecr/Dockerfile.linux.amd64    -t ymage/buildah-ecr .
docker build -f docker/docker/Dockerfile.linux.amd64 -t ymage/buildah-docker .
docker build -f docker/acr/Dockerfile.linux.amd64    -t ymage/buildah-acr .
docker build -f docker/heroku/Dockerfile.linux.amd64 -t ymage/buildah-heroku .
