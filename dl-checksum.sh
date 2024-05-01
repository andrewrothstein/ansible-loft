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
    local dotexe=${6:-}
    local platform="${os}-${arch}"
    # https://github.com/loft-sh/loft/releases/download/v3.3.4/loft-linux-amd64
    local file="${app}-${platform}${dotexe}"
    local url="${MIRROR}/${ver}/${file}"
    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform $(grep -e "$file\$" $lchecksums | grep -v devspace | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    local lchecksums="${DIR}/loft-${ver}-checksums.txt"
    # https://github.com/loft-sh/loft/releases/download/v3.3.4/checksums.txt
    local url="${MIRROR}/${ver}/checksums.txt"
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $url
    fi

    printf "  # %s\n" $url
    printf "  %s:\n" $ver
    printf "    %s:\n" loft
    dl loft $lchecksums $ver darwin amd64
    dl loft $lchecksums $ver darwin arm64
    dl loft $lchecksums $ver linux amd64
    dl loft $lchecksums $ver linux arm64
    dl loft $lchecksums $ver windows amd64 .exe
}

dl_ver ${1:-v3.4.5}
