SERVICE_NAME=console

default: target

target:
	go build $(LDFLAGS) -o $(SERVICE_NAME) main.go

linux:

	env GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o $(SERVICE_NAME) main.go

clean:
	rm $(SERVICE_NAME)

