FROM ubuntu:latest as downloader

ARG DEBIAN_FRONTEND=noninteractive

# Install deps
RUN apt-get update && apt-get install -y \
	wget \
	bzip2 \
	curl 

RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-lint/main/etc/install.sh | BINDIR=/usr/local/bin sh

FROM alpine:latest as arduino-lint
# Alpine uses musl, the arduino-lint binary needs glibc compatibility
RUN apk add gcompat
LABEL org.opencontainers.image.source="https://github.com/scottapotamas/docker-arduino-lint"
COPY --from=0 /usr/local/bin/arduino-lint /usr/local/bin/arduino-lint
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
WORKDIR /root
ENV USER root