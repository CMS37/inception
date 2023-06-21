COMPOSE 	= srcs/docker-compose.yml
NGINX		= srcs/requirements/nginx
WORDPRESS	= srcs/requirements/wordpress
MARIADB		= srcs/requirements/mariadb

all: up

up:
	-mkdir -p /home/min/data /home/min/data/mariadb /home/min/data/wordpress
	docker compose -f $(COMPOSE) up -d

down:
	docker compose -f $(COMPOSE) down

clean:
	docker compose -f $(COMPOSE) down -v --rmi all --remove-orphans

fclean: clean
	-docker rm -f $$(docker ps -a -q)
	-docker volume rm $$(docker volume -ls -q)
	-docker system prune --force --all
	-docker volume prune --force
	-docker network prune --force
	-sudo rm -rf ~/data/*/*

re: fclean all

nginx:
	docker build --no-cache -t nginx $(NGINX)
wordpress:
	docker build --no-cache -t wordpress $(WORDPRESS)
mariadb:
	docker build --no-cache -t mariadb $(MARIADB)

.PHONY: all up down clean fclean re

# docker compose 옵션
# -v : 볼륨 삭제
# --rmi all : 모든 이미지 삭제
# --remove-orphans : 사용하지 않는 컨테이너 삭제

# docker 옵션
# -f $$(docker ps -a -q) : 모든 컨테이너 삭제
# -f $$(docker volume -ls -q) : 모든 볼륨 삭제
# system prune : 사용하지 않는 모든 이미지, 컨테이너, 볼륨, 네트워크 삭제
# volume prune : 사용하지 않는 볼륨 삭제
# network prune : 사용하지 않는 네트워크 삭제
