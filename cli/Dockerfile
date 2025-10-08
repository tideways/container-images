FROM debian:trixie-slim

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		bash-completion \
		ca-certificates \
		curl \
	; \
	rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	groupadd -r tideways; \
	useradd -r -g tideways tideways; \
	mkdir /home/tideways/; \
	echo "source /etc/bash_completion" > /home/tideways/.bashrc; \
	chown -R tideways:tideways /home/tideways/; \
	chmod -R a=,u=rwX /home/tideways/;

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

COPY tideways.sources /etc/apt/sources.list.d/

ENV TIDEWAYS_CLI_VERSION=1.2.14

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	apt-get update; \
	apt-get install -y \
		tideways-cli=$TIDEWAYS_CLI_VERSION \
	; \
	rm -rf /var/lib/apt/lists/*; \
	tideways completion bash >> /home/tideways/.bashrc;

USER tideways

CMD ["tideways"]
