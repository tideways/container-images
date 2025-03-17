FROM debian:bookworm-slim

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

COPY tideways.asc /usr/share/keyrings/tideways.asc

RUN set -eux; \
	groupadd -r tideways; \
	useradd -r -g tideways tideways; \
	mkdir /home/tideways/; \
	echo "source /etc/bash_completion" > /home/tideways/.bashrc; \
	chown -R tideways:tideways /home/tideways/; \
	chmod -R a=,u=rwX /home/tideways/;

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

ENV TIDEWAYS_CLI_VERSION=1.2.8

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	echo 'deb [signed-by=/usr/share/keyrings/tideways.asc] https://packages.tideways.com/apt-packages-main any-version main' |tee /etc/apt/sources.list.d/tideways.list; \
	apt-get update; \
	apt-get install -y \
		tideways-cli=$TIDEWAYS_CLI_VERSION \
	; \
	rm -rf /var/lib/apt/lists/*; \
	tideways completion bash >> /home/tideways/.bashrc;

USER tideways

CMD ["tideways"]
