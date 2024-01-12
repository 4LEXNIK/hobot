APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=41exandr
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./


lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o hobot -ldflags "-X="github.com/4LEXNIK/hobot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:$(VERSION)-${TARGETARCH}
	
push:
	docker push ${REGISTRY}/${APP}:$(VERSION)-${TARGETARCH}

clean:
	rm -rf hobot