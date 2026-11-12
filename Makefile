include .env
export

env-up:
	docker compose up -d

env-down:
	docker compose down
