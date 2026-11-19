include .env
export

env-up:
	docker compose up -d

env-down:
	docker compose down

migrate-create:
	@if [ -z "$(seq)" ]; then \
		echo "Error: seq variable is not set"; \
		exit 1; \
	fi
	mkdir -p migrations
	docker compose run --rm --user $$(id -u):$$(id -g) migrate \
		create \
		-ext sql \
		-dir /migrations \
		-seq $(seq)

migrate-up:
	make migrate-action action=up

migrate-down:
	make migrate-action action=down

migrate-action:
	@if [ -z "$(action)" ]; then \
		echo "Error: action variable is not set, make migrate-action action=\"up\""; \
		exit 1; \
	fi
	docker compose run --rm  migrate \
		-path /migrations \
		-database "postgresql://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable" \
		"$(action)"
