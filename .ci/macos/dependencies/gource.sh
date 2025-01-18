# Dependencies for Gource
# ========================================================================================================
# curl -LO https://github.com/acaudwell/Gource/releases/download/gource-0.55/gource-0.55.tar.gz
# tar -xzf gource-0.55.tar.gz
# cd gource-0.55
# ./configure
# make
# sudo make install
# ========================================================================================================

# download and check sum
curl -LO https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz
shasum -a 256 SDL2_image-2.0.5.tar.gz

# Verify actual_checksum_value  SDL2_image-2.0.5.tar.gz: OK
# bdd5f6e026682f7d7e1be0b6051b209da2f402a2dd8bd1c4bd9c25ad263108d0
# curl -LO https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz && \
#   echo "actual_checksum_value  SDL2_image-2.0.5.tar.gz" | shasum -a 256 -c - && \
#   tar -xzf SDL2_image-2.0.5.tar.gz && \
#   cd SDL2_image-2.0.5 && \
#   ./configure && \
#   make && \
#   make install && \
#   cd .. && \
#   rm -rf SDL2_image-2.0.5 SDL2_image-2.0.5.tar.gz

curl -LO https://www.libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz && \
  echo "bdd5f6e026682f7d7e1be0b6051b209da2f402a2dd8bd1c4bd9c25ad263108d0  SDL2_image-2.0.5.tar.gz" | shasum -a 256 -c - && \
  tar -xzf SDL2_image-2.0.5.tar.gz && \
  cd SDL2_image-2.0.5 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf SDL2_image-2.0.5 SDL2_image-2.0.5.tar.gz


#   ----------------------------------------------------------------------
# Libraries have been installed in:
#    /usr/local/lib

# If you ever happen to want to link against installed libraries
# in a given directory, LIBDIR, you must either use libtool, and
# specify the full pathname of the library, or use the `-LLIBDIR'
# flag during linking and do at least one of the following:
#    - add LIBDIR to the `DYLD_LIBRARY_PATH' environment variable
#      during execution

# See any operating system documentation about shared libraries for
# more information, such as the ld(1) and ld.so(8) manual pages.
# ----------------------------------------------------------------------
#  ./install-sh -c -d '/usr/local/include/SDL2'
#  /usr/bin/install -c -m 644 SDL_image.h '/usr/local/include/SDL2'
#  ./install-sh -c -d '/usr/local/lib/pkgconfig'
#  /usr/bin/install -c -m 644 SDL2_image.pc '/usr/local/lib/pkgconfig'
----------------------------------------------------------------------