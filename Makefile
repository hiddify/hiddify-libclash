nNAME=hiddify-clashlib
BINDIR=bin
BRANCH=$(shell git branch --show-current)
ifeq ($(BRANCH),Alpha)
VERSION=alpha-$(shell git rev-parse --short HEAD)
else ifeq ($(BRANCH),Beta)
VERSION=beta-$(shell git rev-parse --short HEAD)
else ifeq ($(BRANCH),)
VERSION=$(shell git describe --tags)
else
VERSION=$(shell git rev-parse --short HEAD)
endif

NDK_BIN=$(ANDROID_HOME)/ndk/25.2.9519653/toolchains/llvm/prebuilt/linux-x86_64/bin
GOBUILD=CGO_ENABLED=1 go build -trimpath -tags with_gvisor,with_lwip -ldflags="-w -s" -buildmode=c-shared

android-amd64:
	env GOOS=android GOARCH=amd64 CC=$(NDK_BIN)/x86_64-linux-android21-clang $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.so

android-arm:
	env GOOS=android GOARCH=arm GOARM=7 CC=$(NDK_BIN)/armv7a-linux-androideabi21-clang $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.so

android-arm64:
	env GOOS=android GOARCH=arm64 CC=$(NDK_BIN)/aarch64-linux-android21-clang $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.so

windows-amd64:
	env GOOS=windows GOARCH=amd64 CC=x86_64-w64-mingw32-gcc $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.dll
windows-386:
	env GOOS=windows GOARCH=386 CC=i686-w64-mingw32-gcc $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.dll

linux-amd64:
	env GOOS=linux GOARCH=amd64  $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.so
linux-386:
	env GOOS=linux GOARCH=386  $(GOBUILD) -o $(BINDIR)/$(NAME)-$@.so

macos-amd64:
	env GOOS=darwin GOARCH=amd64 CGO_CFLAGS="-mmacosx-version-min=10.11" CGO_LDFLAGS="-mmacosx-version-min=10.11" CGO_ENABLED=1 go build -trimpath -tags with_gvisor,with_lwip -buildmode=c-shared -o $(BINDIR)/$(NAME)-$@.dylib
macos-arm64:
	env GOOS=darwin GOARCH=arm64 CGO_CFLAGS="-mmacosx-version-min=10.11" CGO_LDFLAGS="-mmacosx-version-min=10.11" CGO_ENABLED=1 go build -trimpath -tags with_gvisor,with_lwip -buildmode=c-shared -o $(BINDIR)/$(NAME)-$@.dylib


all:android-amd64 android-arm android-arm64 windows-amd64


gz_releases=$(addsuffix .gz, $(all))

$(gz_releases): %.gz : %
	chmod +x $(BINDIR)/$(NAME)-$(basename $@)
	gzip -f -S -$(VERSION).gz $(BINDIR)/$(NAME)-$(basename $@)

releases: $(gz_releases)

clean:
	rm $(BINDIR)/*
