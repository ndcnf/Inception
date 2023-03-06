FROM alpine:3.16
RUN apk update
RUN apk add bash vim nginx
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 443
