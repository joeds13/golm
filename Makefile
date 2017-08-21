VERSION := make
PORT := 1337


all: build run-server

clean: clean-ui clean-server

build: build-ui build-server

docker: build-docker run-docker


build-docker:
	docker build -t golm:$(VERSION) .

build-server:
	CGO_ENABLED=0 go build -o golm server/server.go

build-ui:
	cd ui; elm-make --yes ui.elm --output ../js/app.js; cd ..; \

clean-server:
	rm ./golm || true

clean-ui:
	rm ./js/app.js || true

run-docker:
	docker run --rm -it -p $(PORT):1337 golm:$(VERSION)

run-server:
	./golm

run-ui:
	cd ui; elm-reactor
