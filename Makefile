include .env
export

export PROJECT_ROOT=$(pwd)

env-up:
	docker compose up

env-down:
	docker compose down
