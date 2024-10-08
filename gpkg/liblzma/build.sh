TERMUX_PKG_HOMEPAGE=https://tukaani.org/xz/
TERMUX_PKG_DESCRIPTION="XZ-format compression library"
TERMUX_PKG_LICENSE="LGPL-2.1, GPL-2.0, GPL-3.0"
TERMUX_PKG_LICENSE_FILE="COPYING, COPYING.GPLv2, COPYING.GPLv3, COPYING.LGPLv2.1"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION="5.6.3"
TERMUX_PKG_SRCURL=https://github.com/tukaani-project/xz/releases/download/v$TERMUX_PKG_VERSION/xz-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=db0590629b6f0fa36e74aea5f9731dc6f8df068ce7b7bafa45301832a5eebc3a
TERMUX_PKG_DEPENDS="glibc, bash-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-sandbox=no
"
