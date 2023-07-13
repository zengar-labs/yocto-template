#!/bin/bash
# Kicks off the build for the ecen5013 custom image
set -e
pushd `dirname $0`

git submodule init
git submodule sync
git submodule update

echo "Initializing build environment"
source poky/oe-init-build-env

set +e
bitbake-layers show-layers | grep "meta-hell" > /dev/null
missing_layer=$?

set -e
if [ $missing_layer -ne 0  ]; then
	echo "Adding meta-hell layer"
	bitbake-layers add-layer ../meta-hell
fi

bitbake core-image-hell