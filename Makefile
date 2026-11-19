include .env
export

MAKEFLAGS += --no-print-directory

env-up:
	docker compose up -d todoapp-postgres todoapp-adminer

env-down:
	docker compose down todoapp-postgres todoapp-adminer

env-port-forward:
	@docker compose up -d port-forwarder

env-port-stop:
	@docker compose down port-forwarder

migrate-create:
	@if [ -z "$(seq)" ]; then \
		echo "Error: seq variable is not set"; \
		exit 1; \
	fi
	mkdir -p migrations
	docker compose run --rm --user $$(id -u):$$(id -g) todoapp-postgres-migrate \
		create \
		-ext sql \
		-dir /migrations \
		-seq $(seq)

migrate-up:
	@$(MAKE) migrate-action action=up

migrate-down:
	@$(MAKE) migrate-action action=down

migrate-action:
	@if [ -z "$(action)" ]; then \
		echo "Error: action variable is not set, make migrate-action action=\"up\""; \
		exit 1; \
	fi
	@docker compose run --rm  todoapp-postgres-migrate \
		-path /migrations \
		-database "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@todoapp-postgres:5432/$(POSTGRES_DB)?sslmode=disable" \
		"$(action)"

migrate-force:
	@if [ -z "$(v)" ]; then \
		echo "Error: v variable is not set, make migrate-force v=1 (or v=-1 for no version)"; \
		exit 1; \
	fi
	@docker compose run --rm todoapp-postgres-migrate \
		-path /migrations \
		-database "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@todoapp-postgres:5432/$(POSTGRES_DB)?sslmode=disable" \
		force -- $(v)
