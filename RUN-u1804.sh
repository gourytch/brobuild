#! /bin/bash
set -e
set -x

base=$(dirname $(readlink -f $0))
io=$base/io-u1804
mkdir -p $io
docker build -t brobuild:u1804 $base
docker run -it --rm -v $io:/io brobuild:u1804 bash -c "/build.sh /io"
docker run -it --rm -v $io:/io brobuild:u1804 bash -c "chown -R $(id -u):$(id -g) /io/*"
echo "done."
