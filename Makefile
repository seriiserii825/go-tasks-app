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
