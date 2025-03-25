#!/bin/bash

PWD=$(pwd)
ARCH=$1
source $PWD/scripts-checking/init.sh

set -e

list_pkgs_in_dir() {
	for i in $(ls $PATH_REPO); do
		echo $i
		for j in $(find $PATH_REPO/$i -name "*.subpackage.sh" -execdir basename {} ';'); do
			echo ${j//.subpackage.sh/}
		done
	done
}

check_pkg_version() {
	for __pkgver in $2; do
		if [ "$1" = "${__pkgver}" ]; then
			return 1
		fi
	done
	return 0
}

clear_log_file

if [ -f "$PACKAGES" ]; then
	rm $PACKAGES
fi

curl $URL -o $PACKAGES

for i in $(list_pkgs_in_dir); do
	PKGNAME=$(package__add_prefix_glibc_to_package_name $i)
	BUILD_SOURCE=$(find_build_source $i)
	if [ -z "$BUILD_SOURCE" ]; then
		error "not found source of '$i'"
	fi
	SUPPORT_ARCH=$(support_arch_pkg $i $BUILD_SOURCE)
	if ! check_pkg_existence $PKGNAME; then
		if [ "$SUPPORT_ARCH" = "true" ]; then
			echo "does not exist - ${PKGNAME}"
			pkg_not_found "$i"
		fi
		continue
	fi
	if [ "$SUPPORT_ARCH" = "false" ]; then
		echo "architecture not supported - ${PKGNAME}"
		arch_not_support "$i"
		continue
	fi
	version_src=$(get_version_src $BUILD_SOURCE)
	version_db=($(get_version_db $PKGNAME))
	if check_pkg_version "${version_src}" "${version_db[@]}"; then
		echo "not found version of '${PKGNAME}': proposed - (${version_db[@]}), should - '${version_src}'"
		ver_not_found "$i"
	else
		echo "all is well with '${PKGNAME}': '${version_src}' in (${version_db[@]})"
	fi
done
