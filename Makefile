VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

format:
	gofmt -s -w ./


lint:
	golint

test:
	go test -v

build: format 
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o hobot -ldflags "-X="github.com/4LEXNIK/hobot/cmd.appVersion=${VERSION}

clean:
	rm -rf hobot