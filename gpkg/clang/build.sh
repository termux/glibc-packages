TERMUX_PKG_HOMEPAGE=https://llvm.org/
TERMUX_PKG_DESCRIPTION="Compiler infrastructure"
TERMUX_PKG_LICENSE="Apache-2.0, NCSA"
TERMUX_PKG_LICENSE_FILE="LICENSE.TXT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=19.1.1
_SOURCE=https://github.com/llvm/llvm-project/releases/download/llvmorg-$TERMUX_PKG_VERSION
TERMUX_PKG_SRCURL=($_SOURCE/clang-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/clang-tools-extra-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/llvm-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/cmake-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/third-party-$TERMUX_PKG_VERSION.src.tar.xz)
TERMUX_PKG_SHA256=(73881ccf065c35ca67752c2d4b6dd0157140330eef318fb80f1a62681145cf7c
		8ec25a9a97a28e2b57b6682f3671f9ca3640794d6f7ce8412acbbf2ed989bcff
		15a7c77f9c39444d9dd6756b75b9a70129dcbd1e340724a6e45b3b488f55bc4b
		92a016ecfe46ad7c18db6425a018c2c6ee126b9d0e5513d6fad989fee6648ffa
		39dec41a0a4d39af6428a58ddbd5c3e5c3ae4f6175e3655480909559cba86cb7)
TERMUX_PKG_DEPENDS="libllvm-glibc, gcc-glibc, compiler-rt-glibc, lld-glibc"
TERMUX_PKG_BUILD_DEPENDS="llvm-glibc, python-glibc"
TERMUX_PKG_NO_STATICSPLIT=true

termux_step_post_get_source() {
	for i in cmake third-party; do
		rm -fr $TERMUX_TOPDIR/$TERMUX_PKG_NAME/${i}
		mv $TERMUX_PKG_SRCDIR/$i-$TERMUX_PKG_VERSION.src $TERMUX_TOPDIR/$TERMUX_PKG_NAME
		mv $TERMUX_TOPDIR/$TERMUX_PKG_NAME/$i-$TERMUX_PKG_VERSION.src $TERMUX_TOPDIR/$TERMUX_PKG_NAME/$i
	done

	mv $TERMUX_PKG_SRCDIR/clang-tools-extra-$TERMUX_PKG_VERSION.src $TERMUX_PKG_SRCDIR/tools/extra
}

termux_step_configure() {
	termux_setup_cmake
	termux_setup_ninja

	local LLVM_TARGET_ARCH="X86"
	if [ $TERMUX_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH="ARM"
	elif [ $TERMUX_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH="AArch64"
	fi

	export PATH=$TERMUX_PKG_BUILDDIR/bin:$PATH

	cmake ${TERMUX_PKG_SRCDIR} \
		-G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_FIND_ROOT_PATH=$TERMUX_PREFIX \
		-DCMAKE_INSTALL_DOCDIR=share/doc \
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX \
		-DCMAKE_SYSTEM_NAME=Linux \
		-DLLVM_HOST_TRIPLE=$TERMUX_HOST_PLATFORM \
		-DCMAKE_LIBRARY_ARCHITECTURE=$TERMUX_HOST_PLATFORM \
		-DCMAKE_SYSTEM_PROCESSOR=$LLVM_TARGET_ARCH \
		-DLLVM_TARGETS_TO_BUILD=$LLVM_TARGET_ARCH \
		-DCMAKE_SKIP_RPATH=ON \
		-DCLANG_DEFAULT_PIE_ON_LINUX=ON \
		-DCLANG_LINK_CLANG_DYLIB=ON \
		-DENABLE_LINKER_BUILD_ID=ON \
		-DLLVM_BUILD_DOCS=ON \
		-DLLVM_BUILD_TESTS=ON \
		-DLLVM_ENABLE_RTTI=ON \
		-DLLVM_ENABLE_SPHINX=ON \
		-DLLVM_EXTERNAL_LIT=$TERMUX_PREFIX/bin/lit \
		-DLLVM_INCLUDE_DOCS=ON \
		-DLLVM_LINK_LLVM_DYLIB=ON \
		-DLLVM_MAIN_SRC_DIR=$TERMUX_PKG_SRCDIR/llvm-$TERMUX_PKG_VERSION.src \
		-DSPHINX_WARNINGS_AS_ERRORS=OFF \
		-DLLVM_INCLUDE_TESTS=OFF
}
