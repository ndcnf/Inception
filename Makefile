NAME = inception
WDIR = srcs
ENV = ${WDIR}/.env

# ---- IMAGES ----
NGINX = nginx
MARIADB = mariadb
WORDPRESS = wordpress
ADMINER = adminer

DOCKER = docker compose --project-directory ${WDIR} --env-file ${ENV} -p ${NAME}

all: 	${NAME}

${NAME}:
		${DOCKER} up -d

stop:
		${DOCKER} stop

down:
		${DOCKER} down

ps:
		${DOCKER} ps -a

# ---- EXECUTIONS ----
execn:
		${DOCKER} exec -it ${NGINX} bash

execm:
		${DOCKER} exec -it ${MARIADB} bash

execw:
		${DOCKER} exec -it ${WORDPRESS} bash

execa:
		${DOCKER} exec -it ${ADMINER} bash

# ---- LOGS ----
logsn:
		docker logs my-${NGINX}

logsm:
		docker logs my-${MARIADB}

logsw:
		docker logs my-${WORDPRESS}

logsa:
		docker logs my-${ADMINER}

# ---- CLEAN, RE & PHONIES ----
clean: down

fclean: clean
		${DOCKER} down --volumes

re:		fclean all

.PHONY:	all clean fclean re \
		stop down ps \
		execn execm execw execa \
		logsn logsm logsw logsa
