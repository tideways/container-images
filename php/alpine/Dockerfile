FROM alpine:3.19

LABEL org.opencontainers.image.source="https://github.com/tideways/container-images"

COPY --chmod=0755 get-ext-path.php /tideways/

ENV TIDEWAYS_PHP_VERSION=5.21.2
ENV TIDEWAYS_PHP_SHA256_X64=00c2603dc925580b3a2b89f2936e401b637a4567475f507cb1fcadd2d31ab192
ENV TIDEWAYS_PHP_SHA256_ARM64=5e2621f9f1dda507591cdfe6d609e26ad77fcfd1ac0ab607cffc7ccff6cd2e96

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
