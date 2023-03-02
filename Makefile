NAME = inception
WDIR = srcs
ENV = ${WDIR}/.env

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
clean:
fclean:
re:
.PHONY:	all clean fclean re stop down ps
