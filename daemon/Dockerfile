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

RUN set -eux; \
	groupadd -r tideways; \
	useradd -r -g tideways tideways

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

ENV TIDEWAYS_DAEMON_VERSION=1.9.30

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	echo 'deb [signed-by=/usr/share/keyrings/tideways.asc] https://packages.tideways.com/apt-packages-main any-version main' |tee /etc/apt/sources.list.d/tideways.list; \
	apt-get update; \
	apt-get install -y \
		tideways-daemon=$TIDEWAYS_DAEMON_VERSION \
	; \
	rm -rf /var/lib/apt/lists/*

USER tideways

EXPOSE 9135

CMD ["tideways-daemon"]
