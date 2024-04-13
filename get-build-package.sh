#!/bin/bash

# Script that installs build-package.sh to compile glibc packages

BRANCH="get_hash_from_file.py"

git clone --depth 1 -b ${BRANCH} --single-branch https://github.com/termux/termux-packages.git

for i in build-package.sh clean.sh packages x11-packages scripts; do
	cp -r ./termux-packages/${i} ./
done

rm -fr termux-packages
