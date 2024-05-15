FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
	; \
	rm -rf /var/lib/apt/lists/*

COPY tideways.asc /usr/share/keyrings/tideways.asc

ENV TIDEWAYS_PHP_VERSION 5.8.4

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	echo 'deb [signed-by=/usr/share/keyrings/tideways.asc] https://packages.tideways.com/apt-packages-main any-version main' |tee /etc/apt/sources.list.d/tideways.list; \
	apt-get update; \
	apt-get install -y \
		tideways-php=$TIDEWAYS_PHP_VERSION \
	; \
	rm -rf /var/lib/apt/lists/*
