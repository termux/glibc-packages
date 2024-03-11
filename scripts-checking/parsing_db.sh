check_pkg_existence() {
	grep -q "^Package: $1$" $PACKAGES
	return $?
}

get_version_db() {
	grep "^Package: $1$" -A 5 $PACKAGES | grep '^Version: ' | awk '{printf $2 " "}'
}
