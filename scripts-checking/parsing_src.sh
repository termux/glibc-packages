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
	(
		TERMUX_PKG_PLATFORM_INDEPENDENT=false
		TERMUX_PKG_BLACKLISTED_ARCHES=""
		TERMUX_SUBPKG_PLATFORM_INDEPENDENT=false
		TERMUX_SUBPKG_EXCLUDED_ARCHES=""

		source "${2}" 2> /dev/null || true

		subsrc="$(dirname ${2})/${1}.subpackage.sh"
		if [ -f "${subsrc}" ]; then
			source "${subsrc}" 2> /dev/null || true
			if [ "${TERMUX_SUBPKG_PLATFORM_INDEPENDENT}" = "true" ]; then
				return 0
			fi
			if __sap_arch_here "${TERMUX_SUBPKG_EXCLUDED_ARCHES}"; then
				return 1
			fi
		fi

		if [ "${TERMUX_PKG_PLATFORM_INDEPENDENT}" = "true" ]; then
			return 0
		fi
		if __sap_arch_here "${TERMUX_PKG_BLACKLISTED_ARCHES}"; then
			return 1
		fi
		return 0
	)
	[ "$?" = "0" ] && echo "true" || echo "false"
}

__sap_arch_here() {
	sed -e 's/,//g' -e 's/ /\n/g' <<< "${1}" | grep -q "^${ARCH}$"
	return $?
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
