#!/bin/bash

set -e

if ! eval $(azd env get-values); then
	echo "E: Failed to get environment values from azd" >&2
	exit 1
fi

: ${QUIET=false}
: ${VERBOSE=false}
: ${AZ_ARGS="-g $AZURE_RESOURCE_GROUP_NAME -n $AZURE_CONTAINER_APPS_APP_NAME"}

NL=$'\n'

msg() {
	if ! $QUIET; then
		echo ">>> $*" >&2
	fi
	if $VERBOSE; then
		echo ">>> $*" >&2
	fi
}

run() {
	   msg "Running: $@"
	"$@"
}

confirm() {
	if $QUIET; then
		return
	fi
	read -p ">>> Continue? [y/N] " -n 1 -r >&2
	echo >&2
	case "${REPLY,,}" in
		y) return ;;
	esac
	exit 1
}

cmd_state_remote() {
	case "$1" in
		on)
			REMOTE=true
			shift
			;;
		off)
			REMOTE=false
			shift
			;;
		*)
			msg 'E: Invalid argument.  Use "on" or "off".'
			exit 1
			;;
	esac
	if $REMOTE; then
		if test -z "$AZURE_STORAGE_ACCOUNT_NAME"; then
			msg 'E: AZURE_STORAGE_ACCOUNT_NAME is not set.  Run "azd provision" to create one.'
			exit 1
		fi
		msg 'Updating ~/.azd/config.yaml to enable the remote state backend with Azure Blob Storage.'
		confirm
		run azd config set state.remote.backend AzureBlobStorage
		run azd config set state.remote.config.accountName $AZURE_STORAGE_ACCOUNT_NAME
	else
		msg 'Updating ~/.azd/config.yaml to disable the remote state backend.'
		confirm
		run azd config unset state
	fi
	run azd env refresh
	run azd env list
}

cmd_help() {
	msg "Usage: $0 <command> [options...] [args...]"
	msg "Options:"
	msg "  --quiet, -q                - Do not ask for confirmation"
	msg "  --verbose, -v              - Show detailed output"
	msg "Commands:"
	msg "  state-remote               - Update remote state backend to Azure Blob Storage"
	exit $1
}

OPTIONS=$(getopt -o hqv -l help,quiet,verbose -- "$@")
if test $? -ne 0; then
	cmd_help 1
fi

eval set -- "$OPTIONS"

while true; do
	case "$1" in
		-h|--help)
			cmd_help 0
			;;			
		-q|--quiet)
			QUIET=true
			shift
			;;
		-v|--verbose)
			VERBOSE=true
			shift
			;;
		--)
			shift
			break
			;;
		*)
			msg "E: Invalid option: $1"
			cmd_help 1
			;;
	esac
done

if test $# -eq 0; then
	msg "E: Missing command"
	cmd_help 1
fi

case "$1" in
	state-remote)
		shift
		cmd_state_remote "$@"
		;;
	*)
		msg "E: Invalid command: $1"
		cmd_help 1
		;;
esac