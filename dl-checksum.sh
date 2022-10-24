#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/loft-sh/loft/releases/download

dl()
{
    local app=$1
    local ver=$2
    local os=$3
    local arch=$4
    local dotexe=${5:-}
    local platform=${os}-${arch}
    local url=$MIRROR/$ver/${app}-${platform}${dotexe}.sha256
    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform $(curl -sSLf $url | awk '{print $1}')
}

dl_ver() {
    local ver=$1

    printf "  %s:\n" $ver
    printf "    %s:\n" loft
    dl loft $ver darwin amd64
    dl loft $ver darwin arm64
    dl loft $ver linux 386
    dl loft $ver linux amd64
    dl loft $ver linux arm64
    dl loft $ver windows 386 .exe
    dl loft $ver windows amd64 .exe
}

dl_ver ${1:-v2.3.2}
