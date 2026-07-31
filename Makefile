DOCKER_COMPOSE_FILE = docker compose -f srcs/docker-compose.yml

makeDir:
	@mkdir -p ~/data/mariadbDatabase
	@mkdir -p ~/data/wordpress

build: makeDir
	$(DOCKER_COMPOSE_FILE) up -d --build

up:
	$(DOCKER_COMPOSE_FILE) up -d

clean:
	$(DOCKER_COMPOSE_FILE) down

fclean:
	$(DOCKER_COMPOSE_FILE) down --rmi all -v
	
logs:
	$(DOCKER_COMPOSE_FILE) logs -f

ps:
	$(DOCKER_COMPOSE_FILE) ps
