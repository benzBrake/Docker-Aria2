#!/bin/sh
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    set -exo pipefail
fi
# Download Aria2
if [[ ${BUILD_VERSION} = "latest" ]]; then
    _LINK="https://github.com$(curl -sL -o - https://github.com/q3aql/aria2-static-builds/releases/${BUILD_VERSION} | grep "aria2-.*-linux-gnu-64bit-build[1-9].tar.bz2" | grep "<a" | awk -F '"' '{print $2}' | head -n1)"
else
    _SLINK=$(curl -sL -o - https://github.com/q3aql/aria2-static-builds/releases/${BUILD_VERSION} | grep "aria2-.*-linux-gnu-64bit-build[1-9].tar.bz2" | grep "<a" | awk -F '"' '{print $2}' | grep ${BUILD_VERSION})
    if [[ -z ${_SLINK} ]]; then
        exit 1
    fi
    _LINK="https://github.com${_SLINK}"
fi
_FILENAME=$(echo ${_LINK} | sed "s#.*/##" |  sed "s#.tar.bz2##")
curl -sSL ${_LINK} -o ${_FILENAME}.tar.bz2
bzip2 -d ${_FILENAME}.tar.bz2
tar xf ${_FILENAME}.tar
rm -f ${_FILENAME}.tar
# Hack old version
if [[ ! -d ${_FILENAME} ]]; then
    if [[ -f /usr/bin/aria2c ]]; then
        mkdir /aria2
        cp /usr/bin/aria2c /aria2/
        cp /etc/ssl/certs/ca-certificates.crt /aria2/
    elif [[ -f /aria2c ]]; then
        mkdir /aria2
        cp /aria2c /aria2/
        cp /ca-certificates.crt /aria2/
    else
        exit 1
    fi
else
    mv ${_FILENAME} /aria2
fi 
# Download Aira2ng
curl -sSL https://github.com$(curl -sSL -o - https://github.com/mayswind/AriaNg/releases/latest | grep "AriaNg-[^/]*-AllInOne.zip" | grep "<a" | awk -F'"' '{print $2}') -o Aria2ng.zip
unzip Aria2ng.zip
mv index.html /data/