VERSION

format:
	gofmt  -s -w ./

	build: 
		go build -v -o hobot -ldflags "-X="github.com/4LEXNIK/hobot/cmd.appVersion=${VERSION}