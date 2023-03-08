NAME = inception
WDIR = srcs
ENV = ${WDIR}/.env

include ${ENV}

# ---- IMAGES ----
NGINX = nginx
MARIADB = mariadb
WORDPRESS = wordpress
ADMINER = adminer

MKDIR = mkdir -p
DOCKER = docker compose --project-directory ${WDIR} --env-file ${ENV} -p ${NAME}

all:	volume dirs ${NAME}

volume:
		$(MKDIR) $(VOLUME_DIR)
		$(MKDIR) $(VOLUME_WP)
		$(MKDIR) $(VOLUME_DB)

dirs:
		$(MKDIR) $(NGINX_DIR)
		$(MKDIR) $(NGINX_SSL)
		$(MKDIR) $(NGINX_CONF)

${NAME}:
		${DOCKER} up -d --build

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

build:
		${DOCKER} build --no-cache

# ---- CLEAN, RE & PHONIES ----
clean: down

fclean: clean
		${DOCKER} down --volumes
		rm -rf ${VOLUME_DIR}

re:		fclean all

.PHONY:	all clean fclean re \
		stop down ps nwk volume dirs \
		execn execm execw execa build \
		logsn logsm logsw logsa logs live
