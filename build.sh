#! /bin/bash
set -e
[ -n "$1" ] || { echo "usage: $0 workdir" 1>&2; exit 1; }
base=$(readlink -f $1)

mkdir -p $base
bdb_prefix=$base/bdb48

wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
echo '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef  db-4.8.30.NC.tar.gz' | sha256sum -c
tar xzpf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix/
../dist/configure \
    --enable-cxx --enable-static --disable-shared --with-pic \
    --prefix=$bdb_prefix
make all install

cd $base
git clone https://github.com/thebitradio/Bitradio.git
cd Bitradio/src
chmod 0755 leveldb/build_detect_platform secp256k1/autogen.sh
make -C leveldb libleveldb.a libmemenv.a

cd $base/Bitradio
./autogen.sh
./configure --enable-cxx \
    --enable-static --disable-shared --with-pic \
    --enable-hardening --with-gui=no \
    LDFLAGS="-L$bdb_prefix/lib" CPPFLAGS="-I$bdb_prefix/include"
make

for name in bitradio-cli bitradio-tx bitradiod ; do
  strip src/$name
  cp src/$name $base/
done
