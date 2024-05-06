#!/bin/bash

set -e

# Check if the first argument starts with a hyphen
# and prepend the binary name.
if [ "${1#-}" != "$1" ]; then
	set -- tideways-daemon "$@"
fi

if [ "$1" = "tideways-daemon" ]; then
	shift # "tideways-daemon"

	export TIDEWAYS_SOURCE=official-image

	TIDEWAYS_DAEMON_EXTRA=
	if [ -f /etc/default/tideways-daemon ]; then
		source /etc/default/tideways-daemon
	fi

	hostname=
	# Set a readable hostname if the hostname looks like Docker's
	# default hostname derived from the container ID.
	if [[ "$(hostname)" =~ ^[0-9a-f]{12}$ ]]; then
		hostname=--hostname=tideways-daemon
	fi

	# In case of duplicate arguments, the last argument wins.
	#
	# 1. --address and $hostname specify useful defaults for use within a
	#    container.
	# 2. Next add $TIDEWAYS_DAEMON_EXTRA coming from
	#    /etc/default/tideways-daemon.
	# 3. Any command line arguments win.
	set -- tideways-daemon \
		--address="[::]:9135" $hostname \
		$TIDEWAYS_DAEMON_EXTRA \
		"$@"
fi

exec "$@"
