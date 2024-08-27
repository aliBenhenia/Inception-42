all:
	docker-compose -f ./srcs/docker-compose.yml ps

up:
	sudo mkdir -p /home/abenheni/data/mariadb /home/abenheni/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	sudo rm -rf /home/abenheni/data/mariadb /home/abenheni/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

status:
	docker ps