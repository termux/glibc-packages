PATH_LOG_PKG=$PATH_RESULT/PKG_NOT_FOUND.$ARCH
PATH_LOG_ARCH=$PATH_RESULT/ARCH_NOT_SUPPORT.$ARCH
PATH_LOG_VER=$PATH_RESULT/VER_NOT_FOUND.$ARCH

pkg_not_found() {
	echo "$1" >> $PATH_LOG_PKG
}

arch_not_support() {
	echo "$1" >> $PATH_LOG_ARCH
}

ver_not_found() {
	echo "$1" >> $PATH_LOG_VER
}

clear_log_file() {
	for __path in $PATH_LOG_PKG $PATH_LOG_ARCH $PATH_LOG_VER; do
		if [ -f ${__path} ]; then
			rm ${__path}
		fi
	done
}
