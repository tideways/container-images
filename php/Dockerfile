FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

COPY --chmod=0755 get-ext-path.php /tideways/

ENV TIDEWAYS_PHP_VERSION=5.22.0
ENV TIDEWAYS_PHP_SHA256_X64=4852606d7ee31456b4180253aadc320d133dbc16e3f05648fab6544eb8c9ae7c
ENV TIDEWAYS_PHP_SHA256_ARM64=cd8547d24ef572919a0a975d6f89bbbe6ab3a87b9d6805379b2c494abd254a00

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	buildDeps='curl ca-certificates'; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		$buildDeps \
	; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		arm64) arch='arm64' checksum="$TIDEWAYS_PHP_SHA256_ARM64" ;; \
		amd64) arch='x86_64' checksum="$TIDEWAYS_PHP_SHA256_X64" ;; \
		*) echo >&2 "error: unsupported architecture: $dpkgArch"; exit 1 ;; \
	esac; \
	\
	curl -fsSL "https://tideways.s3.amazonaws.com/extension/${TIDEWAYS_PHP_VERSION}/tideways-php-${TIDEWAYS_PHP_VERSION}-${arch}.tar.gz" -o tideways-php.tar.gz; \
	echo "$checksum *tideways-php.tar.gz" |sha256sum -c; \
	mkdir -p /tmp/tideways/; \
	tar xvf tideways-php.tar.gz --strip-components=1 -C /tmp/tideways/; \
	cp /tmp/tideways/*.so /tideways/; \
	\
	rm -r /tmp/tideways/; \
	rm tideways-php.tar.gz; \
	apt-get purge -y --auto-remove \
		$buildDeps; \
	rm -rf /var/lib/apt/lists/*;
