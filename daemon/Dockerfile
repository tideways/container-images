FROM debian:trixie-slim

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
	; \
	rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	groupadd -r tideways; \
	useradd -r -g tideways tideways

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

COPY tideways.sources /etc/apt/sources.list.d/

ENV TIDEWAYS_DAEMON_VERSION=1.10.0

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	apt-get update; \
	apt-get install -y \
		tideways-daemon=$TIDEWAYS_DAEMON_VERSION \
	; \
	rm -rf /var/lib/apt/lists/*

USER tideways

EXPOSE 9135

CMD ["tideways-daemon"]
