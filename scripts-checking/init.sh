error() {
	echo "Error: $1"
	exit 1
}

if [ -z "$ARCH" ]; then
	ARCH=aarch64
else
	case $ARCH in
		"aarch64"|"arm"|"x86_64"|"i686") ;;
		*) error "architecture '$ARCH' is not supported";;
	esac
fi

PATH_RESULT=$PWD/result-checking
PATH_SCRIPTS=$PWD/scripts-checking
PATH_REPO=$PWD/gpkg

URL=https://packages.termux.dev/apt/termux-glibc/dists/glibc/stable/binary-$ARCH/Packages
PACKAGES=$PATH_RESULT/Packages-$ARCH

source $PATH_SCRIPTS/package.sh
source $PATH_SCRIPTS/parsing_src.sh
source $PATH_SCRIPTS/parsing_db.sh
source $PATH_SCRIPTS/file_log.sh

if [ ! -d "$PATH_RESULT" ]; then
	mkdir $PATH_RESULT
fi

if [ ! -d "$PATH_REPO" ]; then
	error "repo folder not found"
fi
