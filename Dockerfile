FROM alpine:latest
ENV NO_PROXY .svc.cluster.local,.service.consul
ARG URL_TO_CURL
RUN apk add --update curl && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
