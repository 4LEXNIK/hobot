APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=41exandr
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

TARGETOS=linux
TARGETARCH=amd64

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v


build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o hobot -ldflags "-X="github.com/4LEXNIK/hobot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:$(VERSION)-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH}
	
push:
	docker push ${REGISTRY}/${APP}:$(VERSION)-${TARGETARCH}

clean:
	rm -rf hobot

# Добавляем новые цели для сборки под разные платформы
linux:
	$(MAKE) build TARGETOS=linux TARGETARCH=amd64

arm:
	$(MAKE) build TARGETOS=linux TARGETARCH=arm64

macos:
	$(MAKE) build TARGETOS=darwin TARGETARCH=amd64

windows:
	$(MAKE) build TARGETOS=windows TARGETARCH=amd64