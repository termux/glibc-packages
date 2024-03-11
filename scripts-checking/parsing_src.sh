find_build_source() {
	local name="$1"
	local source="$PATH_REPO/$name/build.sh"

	if [ -f "${source}" ]; then
		echo "${source}"
		return
	fi

	source=$(ls ${PATH_REPO}/*/${name}.subpackage.sh 2> /dev/null) || true
	if [ -n "$source" ]; then
		echo ${source//$name.subpackage.sh/build.sh}
		return
	fi
}

support_arch_pkg() {
	local pkgname="$1"
	local source_file
	(
		source_file="$(dirname ${2})/${pkgname}.subpackage.sh"
		if [ -f "${source_file}" ]; then
			source "${source_file}" 2> /dev/null || true
			! ([ -n "${TERMUX_SUBPKG_EXCLUDED_ARCHES-}" ] && grep -q "$ARCH" <<< "${TERMUX_SUBPKG_EXCLUDED_ARCHES}")
		else
			source "${2}" 2> /dev/null || true
			! ([ -n "${TERMUX_PKG_BLACKLISTED_ARCHES-}" ] && grep -q "$ARCH" <<< "${TERMUX_PKG_BLACKLISTED_ARCHES}")
		fi
		[ "$?" = "0" ] && echo "true" || echo "false"
	)
}

get_version_src() {
	local source_file="$1"
	(
		local TERMUX_PKG_REVISION=0
		source $source_file 2> /dev/null || true
		if [ "$TERMUX_PKG_REVISION" != "0" ] || [ "$TERMUX_PKG_VERSION" != "${TERMUX_PKG_VERSION/-/}" ]; then
			echo "$TERMUX_PKG_VERSION-$TERMUX_PKG_REVISION"
		else
			echo "$TERMUX_PKG_VERSION"
		fi
	)
}
