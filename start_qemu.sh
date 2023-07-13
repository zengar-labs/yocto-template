#!/bin/bash

pushd `dirname $0`

echo "Initializing build environment"
source poky/oe-init-build-env

runqemu qemux86 nographic