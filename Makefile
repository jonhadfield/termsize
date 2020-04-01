setup:
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install --update

lint:
	golangci-lint run --tests=false --enable-all --disable lll --disable interfacer --disable gochecknoglobals

fmt:
	find . -name '*.go' -not -wholename './vendor/*' | while read -r file; do gofmt -w -s "$$file"; goimports -w "$$file"; done

build:
	GOOS=darwin CGO_ENABLED=0 GOARCH=amd64 go build -ldflags '-s -w' -o ".local_dist/termsize_darwin_amd64" main.go

build-all:
	GOOS=darwin  CGO_ENABLED=0 GOARCH=amd64 go build -ldflags '-s -w' -o ".local_dist/termsize_darwin_amd64" main.go
	GOOS=linux   CGO_ENABLED=0 GOARCH=amd64 go build -ldflags '-s -w' -o ".local_dist/termsize_linux_amd64" main.go
	GOOS=linux   CGO_ENABLED=0 GOARCH=arm   go build -ldflags '-s -w' -o ".local_dist/termsize_linux_arm" main.go
	GOOS=linux   CGO_ENABLED=0 GOARCH=arm64 go build -ldflags '-s -w' -o ".local_dist/termsize_linux_arm64" main.go
	GOOS=netbsd  CGO_ENABLED=0 GOARCH=amd64 go build -ldflags '-s -w' -o ".local_dist/termsize_netbsd_amd64" main.go
	GOOS=openbsd CGO_ENABLED=0 GOARCH=amd64 go build -ldflags '-s -w' -o ".local_dist/termsize_openbsd_amd64" main.go
	GOOS=freebsd CGO_ENABLED=0 GOARCH=amd64 go build -ldflags '-s -w' -o ".local_dist/termsize_freebsd_amd64" main.go

build-linux:
	GOOS=linux CGO_ENABLED=0 GOARCH=amd64 go build -ldflags '-s -w -o ".local_dist/termsize_linux_amd64" main.go

mac-install: build
	install .local_dist/termsize_darwin_amd64 /usr/local/bin/termsize

linux-install: build-linux
	sudo install .local_dist/termsize_linux_amd64 /usr/local/bin/termsize

find-updates:
	go list -u -m -json all | go-mod-outdated -update -direct

.DEFAULT_GOAL := build

