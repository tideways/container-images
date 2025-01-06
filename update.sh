#!/bin/bash

set -euxo pipefail

versions="$(curl -fsSL 'https://app.tideways.io/api/current-versions')"

TIDEWAYS_DAEMON_VERSION="$(echo "$versions" |jq -r '.daemon.version')"
awk \
	-v TIDEWAYS_DAEMON_VERSION="$TIDEWAYS_DAEMON_VERSION" \
	'
		$1 == "ENV" { env=1 }
		env {
			for (i=1; i <= NF; i++) {
				split($i, a, "=");
				if (a[1] == "TIDEWAYS_DAEMON_VERSION") { $i = a[1] "=" TIDEWAYS_DAEMON_VERSION }
			}
		}
		{ print }
		env && !/\\$/ { env=0 }
	' \
	< daemon/Dockerfile > daemon/Dockerfile.new
mv -f daemon/Dockerfile.new daemon/Dockerfile

TIDEWAYS_PHP_VERSION="$(echo "$versions" |jq -r '.php.version')"
awk \
	-v "TIDEWAYS_PHP_VERSION=$TIDEWAYS_PHP_VERSION" \
	-v "TIDEWAYS_PHP_SHA256_X64=$(curl -fsSL "https://tideways.s3.amazonaws.com/extension/${TIDEWAYS_PHP_VERSION}/tideways-php-${TIDEWAYS_PHP_VERSION}-x86_64.tar.gz" |sha256sum |cut -d' ' -f1)" \
	-v "TIDEWAYS_PHP_SHA256_ARM64=$(curl -fsSL "https://tideways.s3.amazonaws.com/extension/${TIDEWAYS_PHP_VERSION}/tideways-php-${TIDEWAYS_PHP_VERSION}-arm64.tar.gz" |sha256sum |cut -d' ' -f1)" \
	'
		$1 == "ENV" { env=1 }
		env {
			for (i=1; i <= NF; i++) {
				split($i, a, "=");
				if (a[1] == "TIDEWAYS_PHP_VERSION") { $i = a[1] "=" TIDEWAYS_PHP_VERSION }
				if (a[1] == "TIDEWAYS_PHP_SHA256_X64") { $i = a[1] "=" TIDEWAYS_PHP_SHA256_X64 }
				if (a[1] == "TIDEWAYS_PHP_SHA256_ARM64") { $i = a[1] "=" TIDEWAYS_PHP_SHA256_ARM64 }
			}
		}
		{ print }
		env && !/\\$/ { env=0 }
	' \
	< php/Dockerfile > php/Dockerfile.new
mv -f php/Dockerfile.new php/Dockerfile

awk \
	-v "TIDEWAYS_PHP_VERSION=$TIDEWAYS_PHP_VERSION" \
	-v "TIDEWAYS_PHP_SHA256_X64=$(curl -fsSL "https://tideways.s3.amazonaws.com/extension/${TIDEWAYS_PHP_VERSION}/tideways-php-${TIDEWAYS_PHP_VERSION}-alpine-x86_64.tar.gz" |sha256sum |cut -d' ' -f1)" \
	-v "TIDEWAYS_PHP_SHA256_ARM64=$(curl -fsSL "https://tideways.s3.amazonaws.com/extension/${TIDEWAYS_PHP_VERSION}/tideways-php-${TIDEWAYS_PHP_VERSION}-alpine-arm64.tar.gz" |sha256sum |cut -d' ' -f1)" \
	' \
		$1 == "ENV" { env=1 }
		env {
			for (i=1; i <= NF; i++) {
				split($i, a, "=");
				if (a[1] == "TIDEWAYS_PHP_VERSION") { $i = a[1] "=" TIDEWAYS_PHP_VERSION }
				if (a[1] == "TIDEWAYS_PHP_SHA256_X64") { $i = a[1] "=" TIDEWAYS_PHP_SHA256_X64 }
				if (a[1] == "TIDEWAYS_PHP_SHA256_ARM64") { $i = a[1] "=" TIDEWAYS_PHP_SHA256_ARM64 }
			}
		}
		{ print }
		env && !/\\$/ { env=0 }
	' \
	< php/alpine/Dockerfile > php/alpine/Dockerfile.new
mv -f php/alpine/Dockerfile.new php/alpine/Dockerfile
