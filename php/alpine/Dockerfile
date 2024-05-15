FROM alpine:3.19

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

ENV TIDEWAYS_PHP_VERSION 5.8.4
ENV TIDEWAYS_PHP_SHA256_X64 6fd6d83ff9d89b9dc3ee8dc1a56b7dd6ebc4ec6db0c990daf2488c58e791dde1
ENV TIDEWAYS_PHP_SHA256_ARM64 bd96b6bdf77d8756d038a74776bdc885e2078142431c2aa8a8408a9929a1d667

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		curl \
	; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) arch='arm64' checksum="$TIDEWAYS_PHP_SHA256_ARM64" ;; \
		x86_64) arch='x86_64' checksum="$TIDEWAYS_PHP_SHA256_X64" ;; \
		*) echo >&2 "error: unsupported architecture: $apkArch"; exit 1 ;; \
	esac; \
	curl -fsSL "https://tideways.s3.amazonaws.com/extension/${TIDEWAYS_PHP_VERSION}/tideways-php-${TIDEWAYS_PHP_VERSION}-alpine-${arch}.tar.gz" -o tideways-php-alpine.tar.gz; \
	echo "$checksum *tideways-php-alpine.tar.gz" |sha256sum -c; \
	mkdir -p /usr/lib/tideways/; \
	tar xvf tideways-php-alpine.tar.gz --strip-components=1 -C /usr/lib/tideways/; \
	rm tideways-php-alpine.tar.gz; \
	apk del --no-network .build-deps;
