SHELL := /bin/bash

all: test build ## test & build

.PHONY: build
build: ## build
	echo build

.PHONY: test
test: ## test
	echo test

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
