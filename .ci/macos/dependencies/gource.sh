# Dependencies for Gource
# Installs SDL2_image.
# Installs Boost and sets the BOOST_ROOT environment variable.
# Installs GLM using Homebrew.
# Configures Gource with the Boost library path explicitly specified.
# Builds and installs Gource.

# Install dependenciesSDL2_image
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
# ----------------------------------------------------------------------
# ========================================================================================================

# install dependencies boost
# ========================================================================================================
# Install Boost
brew install boost

# Set BOOST_ROOT environment variable
export BOOST_ROOT=$(brew --prefix boost)


# ========================================================================================================
# checking for glm/glm.hpp... no
# configure: error: GLM headers are required. Please see INSTALL
# Install GLM
brew install glm

# install goucre
# ========================================================================================================
curl -LO https://github.com/acaudwell/Gource/releases/download/gource-0.55/gource-0.55.tar.gz
tar -xzf gource-0.55.tar.gz
cd gource-0.55
./configure
make
sudo make install

# link BOOST_ROOT
curl -LO https://github.com/acaudwell/Gource/releases/download/gource-0.55/gource-0.55.tar.gz && \
  tar -xzf gource-0.55.tar.gz && \
  cd gource-0.55 && \
  ./configure --with-boost=$BOOST_ROOT && \
  make LDFLAGS="-L$BOOST_ROOT/lib -lboost_filesystem -lboost_system" && \
  sudo make install && \
  cd .. && \
  rm -rf gource-0.55 gource-0.55.tar.gz
# ========================================================================================================


# Gource Usage
gource --output-custom-log repo.log my-repo-location/
gource --output-custom-log repo.log my-repo-location/ --start-date "2019-01-01" --stop-date "2019-12-31"

## path .ci/repo/ 
gource --output-custom-log repo.log ../../ --start-date "2015-01-01" --stop-date "2025-01-18"
gource --seconds-per-day 1 repo.log

# ========================================================================================================
# Customizing Gource
# specific screen resolution
gource -1280x1024 --camera-mode track --hide progress --output-ppm-stream ./out.ppm
--background-colour 000000 --font-colour 336699 --highlight-users --highlight-colour ff0000
--auto-skip-seconds 1 --seconds-per-day 0.051 --title "hmm..." --user-scale 1
--bloom-multiplier 0.5 --bloom-intensity 0.5 --key
--file-extensions repo.log

# (?) WHY fullscreen is too slow
gource -fullscreen --camera-mode track --hide progress --output-ppm-stream ./out.ppm
--background-colour 000000 --font-colour 336699 --highlight-users --highlight-colour ff0000
--auto-skip-seconds 1 --seconds-per-day 0.05 --title "hmm..." --user-scale 1
--bloom-multiplier 0.5 --bloom-intensity 0.5 --key
--file-extensions repo.log
# ========================================================================================================

