.PHONY : all up stop logs config infos ps down check clean fclean re

# files
DCOMP_F = docker-compose.yml
VOLUM_F = wp maria redis

# directory
DCOMP_D = $${PWD}/srcs/
VOLUM_D = $${HOME}/data/

# path
DCOMP = $(addprefix $(DCOMP_D), $(DCOMP_F))
VOLUM = $(addprefix $(VOLUM_D), $(VOLUM_F))

#################### - RULES - ########################

all :	up

up	:	| $(VOLUM)
	  docker-compose --file $(DCOMP) up -d --build

ps	:
	  docker-compose --file $(DCOMP) ps

logs :
	  docker-compose --file $(DCOMP) logs --tail 15

infos :
	  docker network ls
	  docker volume ls
	  docker images ls -a
	  docker ps -a

config :
	  docker-compose --file $(DCOMP) config

stop :
	  docker-compose --file $(DCOMP) stop

down :
	  docker-compose --file $(DCOMP) down -v

clean :
	  docker-compose --file $(DCOMP) down -v --rmi all --remove-orphans
	  sudo rm -rf $(VOLUM_D)

fclean :
	  $(MAKE) clean
	  docker system prune -a --force
	  docker volume prune --force

re :
	$(MAKE) fclean
	$(MAKE) all


$(VOLUM) :
		mkdir -p -v $(VOLUM)
	  

#################### - DEBUG - ########################


check :
	@echo "DCOM_F = $(DCOMP_F)"
	@echo
	@echo "DCOMP_D = $(DCOMP_D)"
	@echo
	@echo "DCOMP = $(DCOMP)"
	@echo
	@echo "VOLUM_F = $(VOLUM_F)"
	@echo
	@echo "VOLUM_D = $(VOLUM_D)"
	@echo
	@echo "VOLUM = $(VOLUM)"
	@echo