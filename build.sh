#!/bin/bash

set -ex

# Remove conflicting pre-installed tools

sudo rm $(which swift) $(which swiftc) # these are just symlinks
sudo apt-get remove -y binutils

# Install Swift for cross-compiling (https://gist.github.com/WilsonGramer/038ba7e03c2ac27f4c6d52bd1cf5f2e6)

sudo bash -c 'cat <<EOF > /etc/apt/sources.list
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb [arch=amd64] http://us.archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb [arch=amd64] http://security.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
deb [arch=arm64] http://ports.ubuntu.com/ focal main restricted universe multiverse
deb [arch=arm64] http://ports.ubuntu.com/ focal-updates main restricted universe multiverse
deb [arch=arm64] http://ports.ubuntu.com/ focal-backports main restricted universe multiverse
EOF'
sudo dpkg --add-architecture arm64
sudo apt-get update

curl -s https://packagecloud.io/install/repositories/swift-arm/release/script.deb.sh | sudo bash
sudo apt-get install -y qemu-user-static swiftlang:arm64 libncurses-dev:arm64

# Test

swift --version
swift build

BIN=.build/debug/Sample

file $BIN
$BIN
