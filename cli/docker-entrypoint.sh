#!/bin/bash

set -e

# Check if the first argument starts with a hyphen
# and prepend the binary name.
if [ "${1#-}" != "$1" ]; then
	set -- tideways "$@"
# Check if the first argument is a known subcommand
# and prepend the binary name.
elif [ "$(tideways __complete "$1" 2>/dev/null |awk 'NR==1{print $1}')" = "$1" ]; then
	set -- tideways "$@"
fi

if [ "$1 $2" != "tideways import" ]; then
	# Check if:
	# 1. A token is explicitly specified.
	# 2. No stored token is available
	#    or the stored token is no longer valid.
	if [ -n "$TIDEWAYS_CLI_TOKEN" ] || ! tideways import > /dev/null 2>&1; then
		# If the command is not tideways, we only perform a best-effort import.
		if [ "$1" != "tideways" ]; then
			if [ -n "$TIDEWAYS_CLI_TOKEN" ]; then
				tideways import "$TIDEWAYS_CLI_TOKEN" > /dev/null 2>&1 || true
			fi
		else
			if [ -z "$TIDEWAYS_CLI_TOKEN" ]; then
				echo "Please specify the TIDEWAYS_CLI_TOKEN environment variable for automatic set-up of Tideways CLI." >&2
				exit 1
			fi

			# Emit the output of tideways import only if the import failed.
			output="$(tideways import "$TIDEWAYS_CLI_TOKEN" 2>&1)" || {
				status="$?"
				echo -n "$output"
				exit $status
			}
		fi
	fi
fi

exec "$@"
