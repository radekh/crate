#
# Muster recipe for openssl
#
package "openssl", "0.9.8h"
source "http://www.openssl.org/source/openssl-0.9.8h.tar.gz"
sha1    "ced4f2da24a202e01ea22bef30ebc8aee274de86"
depend  "zlib", "1.2.3"

build "./config --prefix=#{File.join( '/', 'usr' )} zlib no-threads no-shared no-kb5"
build "make depend"
build "make"
build "make install_sw INSTALL_PREFIX=#{install_dir}"
build "make clean"