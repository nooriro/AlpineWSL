VER1=3.19
VER2=3.19.1
DATE=240430

OUT_ZIP=Alpine.zip
LNCR_EXE=Alpine.exe

ARCH=x64

DLR=curl
DLR_FLAGS=-L
LNCR_ZIP_EXE=Alpine.exe

all: $(OUT_ZIP)

zip: $(OUT_ZIP)
$(OUT_ZIP): $(ARCH)

x64:
	cd src_x64 && $(MAKE)
	mv src_x64/$(OUT_ZIP) ./$(basename $(OUT_ZIP))-$(VER2)-$(DATE).zip
	cp -p src_x64/apkcache.tar.gz ./apkcache-$(VER2)-$(DATE).tar.gz
	cp -p src_x64/apkcross.tar.gz ./apkcross-$(VER2)-$(DATE).tar.gz

arm64:
	cd src_arm64 && $(MAKE)
	mv src_arm64/$(OUT_ZIP) ./

clean:
	cd src_x64 && make clean
	cd src_arm64 && make clean
