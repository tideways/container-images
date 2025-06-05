FROM alpine:3.22

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

COPY --chmod=0755 get-ext-path.php /tideways/

ENV TIDEWAYS_PHP_VERSION=5.23.0
ENV TIDEWAYS_PHP_SHA256_X64=d79284b7ba447fb992bd13c5adeb9c736ab005ab353ca4562c7050e907fb34fe
ENV TIDEWAYS_PHP_SHA256_ARM64=535597a3e6e6ce9e03b376ff2999b92902e951908d82f6c5a9e75794e71a4276

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		curl \
	; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) arch='arm64' checksum="$TIDEWAYS_PHP_SHA256_ARM64" ;; \
		x86_64) arch='x86_64' checksum="$TIDEWAYS_PHP_SHA256_X64" ;; \
		*) echo >&2 "error: unsupported architecture: $apkArch"; exit 1 ;; \
	esac; \
	\
	curl -fsSL "https://tideways.s3.amazonaws.com/extension/${TIDEWAYS_PHP_VERSION}/tideways-php-${TIDEWAYS_PHP_VERSION}-alpine-${arch}.tar.gz" -o tideways-php-alpine.tar.gz; \
	echo "$checksum *tideways-php-alpine.tar.gz" |sha256sum -c; \
	mkdir -p /tmp/tideways/; \
	tar xvf tideways-php-alpine.tar.gz --strip-components=1 -C /tmp/tideways/; \
	cp /tmp/tideways/*.so /tideways/; \
	\
	rm -r /tmp/tideways/; \
	rm tideways-php-alpine.tar.gz; \
	apk del --no-network .build-deps;
