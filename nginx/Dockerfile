FROM nginx:1.23.2-alpine

RUN apk -U upgrade \
 && apk add util-linux \
            coreutils \
            vim

COPY ./localhost.conf /etc/nginx/conf.d/localhost.conf

CMD ["nginx", "-g", "daemon off;"]
