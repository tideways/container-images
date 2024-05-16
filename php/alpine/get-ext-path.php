#!/usr/bin/env php
<?php

$fullPath = sprintf(
	"%s/tideways-php%s-%d.%d%s.so",
	__DIR__,
	file_exists("/lib/apk/db/installed") ? "-alpine" : "",
	PHP_MAJOR_VERSION,
	PHP_MINOR_VERSION,
	PHP_ZTS ? "-zts" : ""
);

if (!\is_file($fullPath)) {
	fwrite(STDERR, "Unable to determine extension path: $fullPath");
	exit(1);
}

echo $fullPath;
