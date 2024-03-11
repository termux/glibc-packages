# shellcheck shell=sh
# shellcheck disable=SC2039,SC2059

package__is_package_name_have_glibc_prefix() {
	for __pkgname_part in ${1//-/ }; do
		if [ "${__pkgname_part}" = "glibc" ]; then
			return 0
		fi
	done
	return 1
}

package__add_prefix_glibc_to_package_name() {
	if ! package__is_package_name_have_glibc_prefix "${1}"; then
		if [[ "${1}" = *"-static" ]]; then
			echo "${1/-static/-glibc-static}"
		else
			echo "${1}-glibc"
		fi
	else
		echo "${1}"
	fi
}
