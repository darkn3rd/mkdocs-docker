NS ?= darknerd
VERSION ?= latest
IMAGE_NAME ?= mkdocs

.PHONY: build push

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)