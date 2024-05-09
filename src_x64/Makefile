OUT_ZIP=Alpine.zip
LNCR_EXE=Alpine-3.19.exe

DLR=curl
DLR_FLAGS=-L
BASE_URL=https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-minirootfs-3.19.1-x86_64.tar.gz
LNCR_ZIP_URL=https://github.com/yuk7/wsldl/releases/download/23072600/icons.zip
LNCR_ZIP_EXE=Alpine.exe

SHORTCUT_URL=https://github.com/nooriro/alpine-wsl-shortcut/archive/refs/tags/1.0.0.zip
SHORTCUT_FILES=shell_link.ps1 create-shortcut.cmd delete-shortcut.cmd
VARCROSS_URL=https://github.com/nooriro/alpine-wsl-varcross/archive/refs/tags/1.0.0.zip
VARCROSS_FILES=download-extract.sh rm-downloaded.sh rm-extracted.sh

all: $(OUT_ZIP)

zip: $(OUT_ZIP)
$(OUT_ZIP): ziproot
	@echo -e '\e[1;31mBuilding $(OUT_ZIP)\e[m'
	cd ziproot; bsdtar -a -cf ../$(OUT_ZIP) *

ziproot: Launcher.exe rootfs.tar.gz shortcut
	@echo -e '\e[1;31mBuilding ziproot...\e[m'
	mkdir ziproot
	cp -p Launcher.exe ziproot/${LNCR_EXE}
	cp -p rootfs.tar.gz ziproot/
	cp -p `for FILE in $(SHORTCUT_FILES); do echo shortcut/$$FILE; done` ziproot/

exe: Launcher.exe
Launcher.exe: icons.zip
	@echo -e '\e[1;31mExtracting Launcher.exe...\e[m'
	bsdtar -xvf icons.zip $(LNCR_ZIP_EXE)
	mv $(LNCR_ZIP_EXE) Launcher.exe

shortcut: shortcut.zip
	@echo -e '\e[1;31mExtracting files from shortcut.zip...\e[m'
	mkdir shortcut
	bsdtar -xvf shortcut.zip --strip-components=1 -C shortcut

varcross: varcross.zip
	@echo -e '\e[1;31mExtracting files from varcross.zip...\e[m'
	sudo mkdir varcross
	sudo bsdtar -xvf varcross.zip --strip-components=1 -C varcross

icons.zip:
	@echo -e '\e[1;31mDownloading icons.zip...\e[m'
	$(DLR) $(DLR_FLAGS) $(LNCR_ZIP_URL) -o icons.zip

shortcut.zip:
	@echo -e '\e[1;31mDownloading shortcut.zip...\e[m'
	$(DLR) $(DLR_FLAGS) $(SHORTCUT_URL) -o shortcut.zip

varcross.zip:
	@echo -e '\e[1;31mDownloading varcross.zip...\e[m'
	$(DLR) $(DLR_FLAGS) $(VARCROSS_URL) -o varcross.zip

rootfs.tar.gz: rootfs
	@echo -e '\e[1;31mBuilding rootfs.tar.gz...\e[m'
	cd rootfs; sudo tar -zcpf ../rootfs.tar.gz `sudo ls`
	sudo chown `id -un`:`id -gn` rootfs.tar.gz

rootfs: base.tar.gz profile varcross
	@echo -e '\e[1;31mBuilding rootfs...\e[m'
	mkdir rootfs
	sudo tar -zxpf base.tar.gz -C rootfs
	sudo cp -f /etc/resolv.conf rootfs/etc/resolv.conf
	sudo cp -f profile rootfs/etc/profile
	sudo chroot rootfs ln -s /var/cache/apk /etc/apk/cache
	[ -f apkcache.tar.gz ] && sudo tar -zxpf apkcache.tar.gz -C rootfs/var/cache/apk || true
	sudo chroot rootfs /sbin/apk update
	# sudo chroot rootfs /sbin/apk list --installed
	sudo chroot rootfs /sbin/apk upgrade
	# musl-dev musl-dbg
	sudo chroot rootfs /sbin/apk add musl-dev
	sudo chroot rootfs /sbin/apk add musl-dbg
	# gcc
	sudo chroot rootfs /sbin/apk add libgcc;    \
	sudo chroot rootfs /sbin/apk add jansson;   \
	sudo chroot rootfs /sbin/apk add libstdc++; \
	sudo chroot rootfs /sbin/apk add zstd-libs; \
	sudo chroot rootfs /sbin/apk add binutils;  \
	sudo chroot rootfs /sbin/apk add libgomp;   \
	sudo chroot rootfs /sbin/apk add libatomic; \
	sudo chroot rootfs /sbin/apk add gmp;       \
	sudo chroot rootfs /sbin/apk add isl26;     \
	sudo chroot rootfs /sbin/apk add mpfr4;     \
	sudo chroot rootfs /sbin/apk add mpc1 || true
	sudo chroot rootfs /sbin/apk add gcc
	# llvm
	sudo chroot rootfs /sbin/apk add libffi;  \
	sudo chroot rootfs /sbin/apk add xz-libs; \
	sudo chroot rootfs /sbin/apk add libxml2; \
	sudo chroot rootfs /sbin/apk add llvm-linker-tools || true
	sudo chroot rootfs /sbin/apk add llvm
	# clang
	sudo chroot rootfs /sbin/apk add clang-headers;   \
	sudo chroot rootfs /sbin/apk add clang-libs;      \
	sudo chroot rootfs /sbin/apk add fortify-headers; \
	sudo chroot rootfs /sbin/apk add libstdc++-dev || true
	sudo chroot rootfs /sbin/apk add clang
	# lld
	sudo chroot rootfs /sbin/apk add lld-libs; \
	sudo chroot rootfs /sbin/apk add scudo-malloc || true
	sudo chroot rootfs /sbin/apk add lld
	# compiler-rt
	sudo chroot rootfs /sbin/apk add compiler-rt
	# libc++ libc++-static libc++-dev
	sudo chroot rootfs /sbin/apk add libc++
	sudo chroot rootfs /sbin/apk add libc++-dev
	sudo chroot rootfs /sbin/apk add libc++-static
	# llvm-libunwind llvm-libunwind-static llvm-libunwind-dev
	sudo chroot rootfs /sbin/apk add llvm-libunwind
	sudo chroot rootfs /sbin/apk add llvm-libunwind-dev
	sudo chroot rootfs /sbin/apk add llvm-libunwind-static
	# make
	sudo chroot rootfs /sbin/apk add make
	# ninja
	sudo chroot rootfs /sbin/apk add ninja
	# cmake
	sudo chroot rootfs /sbin/apk add libacl;       \
	sudo chroot rootfs /sbin/apk add libbz2;       \
	sudo chroot rootfs /sbin/apk add libexpat;     \
	sudo chroot rootfs /sbin/apk add lz4-libs;     \
	sudo chroot rootfs /sbin/apk add libarchive;   \
	sudo chroot rootfs /sbin/apk add nghttp2-libs; \
	sudo chroot rootfs /sbin/apk add rhash-libs;   \
	sudo chroot rootfs /sbin/apk add libuv || true
	sudo chroot rootfs /sbin/apk add cmake
	# python3
	sudo chroot rootfs /sbin/apk add gdbm;                  \
	sudo chroot rootfs /sbin/apk add mpdecimal;             \
	sudo chroot rootfs /sbin/apk add ncurses-terminfo-base; \
	sudo chroot rootfs /sbin/apk add libncursesw;           \
	sudo chroot rootfs /sbin/apk add libpanelw;             \
	sudo chroot rootfs /sbin/apk add readline;              \
	sudo chroot rootfs /sbin/apk add sqlite-libs;           \
	sudo chroot rootfs /sbin/apk add python3-pycache-pyc0;  \
	sudo chroot rootfs /sbin/apk add pyc;                   \
	sudo chroot rootfs /sbin/apk add python3-pyc || true
	sudo chroot rootfs /sbin/apk add python3
	# gdb
	sudo chroot rootfs /sbin/apk add gcc-gdb || true
	sudo chroot rootfs /sbin/apk add gdb
	# git
	sudo chroot rootfs /sbin/apk add ca-certificates; \
	sudo chroot rootfs /sbin/apk add brotli-libs;     \
	sudo chroot rootfs /sbin/apk add c-ares;          \
	sudo chroot rootfs /sbin/apk add libunistring;    \
	sudo chroot rootfs /sbin/apk add libidn2;         \
	sudo chroot rootfs /sbin/apk add libcurl;         \
	sudo chroot rootfs /sbin/apk add pcre2 || true
	sudo chroot rootfs /sbin/apk add git
	# file
	sudo chroot rootfs /sbin/apk add libmagic || true
	sudo chroot rootfs /sbin/apk add file
	# nano
	sudo chroot rootfs /sbin/apk add nano
	# curl libarchive-tools sudo
	sudo chroot rootfs /sbin/apk add curl
	sudo chroot rootfs /sbin/apk add libarchive-tools
	sudo chroot rootfs /sbin/apk add sudo
	# strace
	sudo chroot rootfs /sbin/apk add libelf;   \
	sudo chroot rootfs /sbin/apk add musl-fts; \
	sudo chroot rootfs /sbin/apk add libdw || true
	sudo chroot rootfs /sbin/apk add strace
	# gcompat
	sudo chroot rootfs /sbin/apk add musl-obstack; \
	sudo chroot rootfs /sbin/apk add libucontext || true
	sudo chroot rootfs /sbin/apk add gcompat
	# bash
	sudo chroot rootfs /sbin/apk add bash
	# sudo chroot rootfs /sbin/apk list --installed
	sudo tar --overwrite -zcpf apkcache.tar.gz -C rootfs/var/cache/apk `sudo ls -tr rootfs/var/cache/apk | grep '\.apk$$'`
	sudo chmod 0644 apkcache.tar.gz
	sudo chown `id -un`:`id -gn` apkcache.tar.gz
	sudo rm -rf `sudo find rootfs/var/cache/apk/ -type f -name '*.apk'`
	# ---------------------------
	# Files for cross compilation
	# ---------------------------
	sudo mkdir rootfs/var/cross
	sudo chmod 0755 rootfs/var/cross
	sudo cp -p `for FILE in $(VARCROSS_FILES); do echo varcross/$$FILE; done` rootfs/var/cross/
	sudo chmod 0744 `for FILE in $(VARCROSS_FILES); do echo rootfs/var/cross/$$FILE; done`
	[ -f apkcross.tar.gz ] && sudo tar -zxpf apkcross.tar.gz -C rootfs/var/cross || true
	sudo chroot rootfs /var/cross/download-extract.sh
	sudo tar --overwrite -zcpf apkcross.tar.gz -C rootfs/var/cross `for ARCH in armv7 aarch64 x86 x86_64; do sudo ls -tr rootfs/var/cross/$$ARCH | sed -n 's/.*\.apk$$/'$$ARCH'\/&/p'; done`
	sudo chmod 0644 apkcross.tar.gz
	sudo chown `id -un`:`id -gn` apkcross.tar.gz
	yes | sudo chroot rootfs /var/cross/rm-downloaded.sh
	# Add symlink to /var/cross by default in each user's home directory, whenever a user account is created
	sudo chroot rootfs mkdir -p /etc/skel
	sudo chroot rootfs ln -s /var/cross /etc/skel/cross
	sudo chroot rootfs ln -s /var/cross /root/cross
	# ------------------------------------
	# End of 'Files for cross compilation'
	# ------------------------------------
	sudo rm -f rootfs/etc/resolv.conf
	sudo chmod +x rootfs

base.tar.gz:
	@echo -e '\e[1;31mDownloading base.tar.gz...\e[m'
	$(DLR) $(DLR_FLAGS) $(BASE_URL) -o base.tar.gz

clean:
	@echo -e '\e[1;31mCleaning files...\e[m'
	-rm ${OUT_ZIP}
	-rm -r ziproot
	-rm Launcher.exe
	-rm rootfs.tar.gz
	-rm -r shortcut
	-sudo rm -r varcross
	-sudo umount rootfs/proc
	-sudo rm -r rootfs
	-rm base.tar.gz
