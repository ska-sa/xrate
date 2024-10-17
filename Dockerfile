# For some reason ARGs need to be repeated multiple times (maybe
# global and image scope?)
ARG VERSION=2.19.2

FROM alpine:3.12 as build
WORKDIR /
RUN apk add tar wget
ARG VERSION=2.19.2
ARG OS=linux
ARG ARCH=amd64
RUN wget --dot=mega https://github.com/free/prometheus/releases/download/${VERSION}-xrate/prometheus-${VERSION}.${OS}-${ARCH}.tar.gz
RUN tar -zxf prometheus-${VERSION}.${OS}-${ARCH}.tar.gz

FROM prom/prometheus:v${VERSION}
ARG VERSION=2.19.2
ARG OS=linux
ARG ARCH=amd64
COPY --from=build /prometheus-${VERSION}.${OS}-${ARCH}/prometheus /bin/prometheus
