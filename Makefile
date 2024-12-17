##========== COLORS ==========##

BASE_COLOR		=	\033[0;39m
BLACK			=	\033[30m
GRAY			=	\033[0;90m
DARK_GRAY		=	\033[37m
RED				=	\033[0;91m
DARK_GREEN		=	\033[32m
DARK_RED		=	\033[31m
GREEN			=	\033[0;92m
ORANGE			=	\033[0;93m
DARK_YELLOW		=	\033[33m
BLUE			=	\033[0;94m
DARK_BLUE		=	\033[34m
MAGENTA			=	\033[0;95m
DARK_MAGENTA	=	\033[35m
CYAN			=	\033[0;96m
WHITE			=	\033[0;97m
BLACK_ORANGE	=	\033[38;2;187;62;3m

help:
	@ clear
	@ echo "$(ORANGE)┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[ HELP ]━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
	@ echo 			"┃ - $(BLUE)help:$(CYAN) Show command list.						$(ORANGE)┃"
	@ echo 			"┃ - $(BLUE)up: $(CYAN)Build and start services.					$(ORANGE)┃"
	@ echo 			"┃	- $(BLUE)up_manda: $(CYAN)Build and start mandatory part services.		$(ORANGE)┃"
	@ echo 			"┃	- $(BLUE)up_bonus: $(CYAN)Build and start bonus part services.		$(ORANGE)┃"
	@ echo 			"┃ - $(BLUE)down: $(CYAN)End services.							$(ORANGE)┃"
	@ echo 			"┃	- $(BLUE)down_manda: $(CYAN)End only mandatory part services.			$(ORANGE)┃"
	@ echo 			"┃	- $(BLUE)down_bonus: $(CYAN)End bonus part services.				$(ORANGE)┃"
	@ echo 			"┃ - $(BLUE)logs: $(CYAN)Create logfiles with docker logs.				$(ORANGE)┃"
	@ echo 			"┃ - $(BLUE)rm_logs: $(CYAN)Delete the logs files.					$(ORANGE)┃"
	@ echo 			"┃ - $(BLUE)static_page: $(CYAN)Show the link to see the static page.			$(ORANGE)┃"
	@ echo "$(ORANGE)┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"

up:
	@ clear
	@ while true; do \
		read -p "Compile with bonus? [y/N] " choice; \
		case $$choice in \
			y|Y) $(MAKE) up_bonus; break ;; \
			n|N|'') $(MAKE) up_manda; break ;; \
			*) echo "Invalid input. Please type 'y' or 'n'."; continue ;; \
		esac; \
	done

down: rm_logs
	@ clear
	@ echo "$(RED)Ending services...$(BASE_COLOR)"
	@ if [ -f ./.DontWorryAboutThisFile ]; then \
		rm -f ./.DontWorryAboutThisFile ;\
		docker compose -f ./srcs/docker-compose_bonus.yml --progress quiet down; \
	else \
		docker compose -f ./srcs/docker-compose.yml --progress quiet down ;\
	fi
	@ echo "$(DARK_GREEN)Services ended !$(BASE_COLOR)"


up_manda:
	@ clear
	@ echo "$(DARK_GREEN)Creating Mandatory!$(BASE_COLOR)"
	@ echo "$(RED)Replacing nginx configuration file...$(BASE_COLOR)"
	@ cp ./srcs/requirements/nginx/conf/inception_manda.conf ./srcs/requirements/nginx/conf/inception.conf
	@ echo "$(DARK_GREEN)Replacement done !$(BASE_COLOR)"
	@ echo "$(RED)Building project...$(BASE_COLOR)"
	@ docker compose -f ./srcs/docker-compose.yml --progress quiet build
	@ echo "$(DARK_GREEN)Build done !$(BASE_COLOR)"
	@ echo "$(RED)Starting services...$(BASE_COLOR)"
	@ docker compose -f ./srcs/docker-compose.yml --progress quiet up -d
	@ echo "$(DARK_GREEN)Services started !$(BASE_COLOR)"

down_manda: rm_logs
	@ clear
	@ echo "$(RED)Ending services...$(BASE_COLOR)"
	@ docker compose -f ./srcs/docker-compose.yml --progress quiet down
	@ echo "$(DARK_GREEN)Services ended !$(BASE_COLOR)"

up_bonus:
	@ clear
	@ echo "$(DARK_GREEN)Creating Bonus!$(BASE_COLOR)"
	@ echo "$(RED)Replacing nginx configuration file...$(BASE_COLOR)"
	@ cp ./srcs/requirements/nginx/conf/inception_bonus.conf ./srcs/requirements/nginx/conf/inception.conf
	@ echo "$(DARK_GREEN)Replacement done !$(BASE_COLOR)"
	@ echo "$(RED)Building project...$(BASE_COLOR)"
	@ docker compose -f ./srcs/docker-compose_bonus.yml --progress quiet build
	@ echo "$(DARK_GREEN)Build done !$(BASE_COLOR)"
	@ echo "$(RED)Starting services...$(BASE_COLOR)"
	@ docker compose -f ./srcs/docker-compose_bonus.yml --progress quiet up -d
	@ echo "$(DARK_GREEN)Services started !$(BASE_COLOR)"
	@ touch .DontWorryAboutThisFile

down_bonus: rm_logs
	@ clear
	@ echo "$(RED)Ending services...$(BASE_COLOR)"
	@ docker compose -f ./srcs/docker-compose_bonus.yml --progress quiet down
	@ echo "$(DARK_GREEN)Services ended !$(BASE_COLOR)"

logs:
	@ echo "$(RED)Creating logs...$(BASE_COLOR)"
	@ docker logs mariadb > mariadb.log
	@ docker logs nginx > nginx.log
	@ docker logs wordpress > wordpress.log
	@ if [ -f ./.DontWorryAboutThisFile ]; then \
		docker logs adminer > adminer.log ;\
		docker logs ftp > ftp.log; \
		docker logs portainer 2> portainer.log; \
		docker logs redis > redis.log; \
		docker logs static > static_page.log; \
	fi
	@ echo "$(DARK_GREEN)Logs created!$(BASE_COLOR)"

static_page:
	@ if [ -f ./.DontWorryAboutThisFile ]; then \
		echo "$(GREEN)You can see the static page on:$(DARK_YELLOW)"; \
		docker logs static | grep "http://"; \
	else \
		echo "$(RED)You haven't build the bonus part" ;\
	fi
	@ echo -n "$(BASE_COLOR)"

rm_logs:
	@ echo "$(RED)Deleting logs...$(BASE_COLOR)"
	@ rm -f adminer.log ftp.log portainer.log redis.log static_page.log mariadb.log nginx.log wordpress.log
	@ echo "$(GREEN)Logs deleted!$(BASE_COLOR)"

clean: down
	@ echo "$(RED)Removing files in .data...$(BASE_COLOR)"
	@ sudo rm -rf ./.data/database/* ./.data/web/*
	@ echo "$(RED)Removing all docker image...$(BASE_COLOR)"
	@ docker system prune -f
	@ echo "$(GREEN)All cleaned !$(BASE_COLOR)"

.PHONY:
	help up down up_manda down_manda up_bonus down_bonus