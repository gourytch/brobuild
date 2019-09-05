#! /bin/bash
set -e
set -x

base=$(dirname $(readlink -f $0))
io=$base/io
mkdir -p $io
docker build -t brobuild $base
docker run --rm -v $io:/io brobuild bash -c "/build.sh /io"
docker run --rm -v $io:/io brobuild bash -c "chown -R $(id -u):$(id -g) /io/*"
echo "done."
