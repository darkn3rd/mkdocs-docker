NS ?= darknerd
VERSION ?= latest
IMAGE_NAME ?= mkdocs
MOCK_NAME ?= mkdocs_mock
.PHONY: build push mock test

build: Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

push:
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)

mock: build
	docker run --rm -d -v $(shell pwd)/test/mock:/opt/docs -p 8000:8000 --name $(MOCK_NAME) darknerd/mkdocs:latest serve

test: mock
	inspec exec test/integration -t docker://$(MOCK_NAME)

stop:
	docker stop $(shell docker ps --filter "name=$(MOCK_NAME)" -q)

clean:
	docker rmi -f $(shell docker images "$(NS)/$(IMAGE_NAME)" -aq)
