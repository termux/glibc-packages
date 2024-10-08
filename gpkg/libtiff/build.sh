TERMUX_PKG_HOMEPAGE=http://www.simplesystems.org/libtiff/ # Note that http://libtiff.org/ is hijacked
TERMUX_PKG_DESCRIPTION="Support for the Tag Image File Format (TIFF) for storing image data"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENSE.md"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="4.7.0"
TERMUX_PKG_SRCURL=https://download.osgeo.org/libtiff/tiff-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=273a0a73b1f0bed640afee4a5df0337357ced5b53d3d5d1c405b936501f71017
TERMUX_PKG_DEPENDS="gcc-libs-glibc, libjpeg-turbo-glibc, zstd-glibc, jbigkit-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-ld-version-script"
