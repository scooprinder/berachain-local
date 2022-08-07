CURRENT_UID := $(id -u)
CURRENT_GID := $(id -g)

start:
	docker-compose build && env UID=${CURRENT_UID} GID=${CURRENT_GID} docker-compose up

startd:
	docker-compose build && env UID=${CURRENT_UID} GID=${CURRENT_GID} docker-compose up -d

stop:
	docker-compose stop

update: docker-compose pull

reset:
	docker-compose rm
	rm -rf ./data/ || true 
	mkdir -p ./data/
	cp priv_validator_state.json ./data

restart: reset start
