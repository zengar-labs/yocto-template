#!/bin/bash

set -e

detect_os() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        OS=$ID
    elif [ -f /etc/redhat-release ]; then
        OS="rhel"
    elif [ "$(uname -s)" == "Darwin" ]; then
        OS="macos"
    else
        echo "Unsupported OS. Please specify the OS manually."
        exit 1
    fi
}

install_qemu() {
    case "$1" in
        "ubuntu" | "debian")
            sudo apt-get install gawk wget git diffstat unzip \
                texinfo gcc build-essential chrpath socat cpio \
                python3 python3-pip python3-pexpect xz-utils \
                debianutils iputils-ping python3-git python3-jinja2 \
                libegl1-mesa libsdl1.2-dev python3-subunit \
                mesa-common-dev zstd liblz4-tool file locales
            ;;
        "rhel")
            sudo dnf install gawk make wget tar bzip2 gzip python3 unzip \
            perl patch diffutils diffstat git cpp gcc gcc-c++ glibc-devel \
            texinfo chrpath ccache perl-Data-Dumper perl-Text-ParseWords \
            perl-Thread-Queue perl-bignum socat python3-pexpect findutils \
            which file cpio python python3-pip xz python3-GitPython \
            python3-jinja2 SDL-devel rpcgen mesa-libGL-devel perl-FindBin \
            perl-File-Compare perl-File-Copy perl-locale zstd lz4 hostname \
            glibc-langpack-en
            ;;
        *)
            echo "Unsupported OS. Please specify a valid OS: ubuntu, debian, rhel, macos."
            exit 1
            ;;
    esac
}

if [ -z "$1" ]; then
    detect_os
else
    OS=$1
fi

install_qemu "$OS"