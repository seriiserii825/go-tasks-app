include .env
export

env-up:
	docker compose up -d

env-down:
	docker compose down

migrate-create:
	@if [ -z "$(name)" ]; then \
		echo "Error: name variable is not set"; \
		exit 1; \
	fi
	docker compose run --rm migrate \
		-ext sql \
		-dir /migrations \
		-seq $(name)
