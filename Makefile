VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

format:
	gofmt -s -w ./

build: 
	go build -v -o hobot -ldflags "-X="github.com/4LEXNIK/hobot/cmd.appVersion=${VERSION}