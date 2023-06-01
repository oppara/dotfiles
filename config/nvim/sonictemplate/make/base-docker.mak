SHELL := /bin/bash

MAKEFILE_DIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
PARENT_DIR := $(shell dirname ${MAKEFILE_DIR})

# 実行するコンテナ名
CONTAINER_NAME := foo

.PHONY: up
up: ## docker-compose up
	docker-compose up -d
	docker-compose ps

.PHONY: stop
stop: ## docker-compose stop
	docker-compose stop

.PHONY: down
down: ## docker-compose down
	docker-compose down

.PHONY: reload
reload: ## down & up
	@make down
	@make up

.PHONY: destroy
destroy: ## docker-compose down -v
	docker-compose down -v

.PHONY: bash
bash: ## docker exec -it ${CONTAINER_NAME} bash
	docker exec -it ${CONTAINER_NAME} bash

.PHONY: setup
setup: ## setup data
	echo setup


.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
