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

nwk:
		docker network ls

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
		${DOCKER} logs ${NGINX}

logsm:
		${DOCKER} logs ${MARIADB}

logsw:
		${DOCKER} logs ${WORDPRESS}

logsa:
		${DOCKER} logs ${ADMINER}

logs:
		${DOCKER} logs

live:
		${DOCKER} logs -f

# ---- CLEAN, RE & PHONIES ----
clean: down

fclean: clean
		${DOCKER} down --volumes

re:		fclean all

.PHONY:	all clean fclean re \
		stop down ps nwk \
		execn execm execw execa \
		logsn logsm logsw logsa logs live
