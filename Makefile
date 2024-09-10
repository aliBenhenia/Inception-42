up  : 
	sudo mkdir -p  /home/volumes/data/mariadb  /home/volumes/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up --build
ps  :
	docker-compose -f ./srcs/docker-compose.yml ps
down:
	docker-compose -f ./srcs/docker-compose.yml down

stop :
	sudo rm -rf  /home/volumes/data/mariadb  /home/volumes/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml stop

start :
	docker-compose -f ./srcs/docker-compose.yml start
