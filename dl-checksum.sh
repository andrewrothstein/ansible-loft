#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/loft-sh/loft/releases/download

dl()
{
    local app=$1
    local lchecksums=$2
    local ver=$3
    local os=$4
    local arch=$5
    local archive_type=${6:-tar.gz}
    local platform="${os}_${arch}"
    # https://github.com/loft-sh/loft/releases/download/v4.1.1/loft_4.1.1_linux_amd64.tar.gz
    local file="${app}_${ver}_${platform}.${archive_type}"
    local url="${MIRROR}/v${ver}/${file}"
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(grep -e "$file\$" $lchecksums | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    local lchecksums="${DIR}/loft-v${ver}-checksums.txt"
    # https://github.com/loft-sh/loft/releases/download/v3.3.4/checksums.txt
    # https://github.com/loft-sh/loft/releases/download/v4.1.1/checksums.txt
    local url="${MIRROR}/v${ver}/checksums.txt"
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $url
    fi

    printf "  # %s\n" $url
    printf "  '%s':\n" $ver
    dl loft $lchecksums $ver linux amd64
    dl loft $lchecksums $ver linux arm64
}

dl_ver ${1:-4.1.1}
