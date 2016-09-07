FROM alpine:latest
ARG URL_TO_CURL
RUN apk add --update curl && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
