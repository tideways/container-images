FROM alpine:3.22

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

COPY --chmod=0755 get-ext-path.php /tideways/

ENV TIDEWAYS_PHP_VERSION=5.25.0
ENV TIDEWAYS_PHP_SHA256_X64=b40c14e53b881f849765b0137c77031b4eaa3bc8651eff67ef68373e9d75664b
ENV TIDEWAYS_PHP_SHA256_ARM64=6ddbb6ff51d9263eca8942b3e98e42d62ac354d65da96d12e02daac15f2ed96a

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
