#!/usr/bin/env bash

### Trap signals
signal_exit() {
    local l_signal
    l_signal="$1"

    case "$l_signal" in
    INT)
        error_exit "Program interrupted by user"
        ;;
    TERM)
        error_exit "Program terminated"
        ;;
    *)
        error_exit "Terminating on unknown signal"
        ;;
    esac
}

trap "signal_exit TERM" TERM HUP
trap "signal_exit INT" INT

### Const
readonly PROGRAM_NAME=${0##*/}
readonly PROGRAM_VERSION="1.0.0"
readonly EXTERNAL_BINARIES="yq git xargs column"

### Args
LOG_LEVEL="STABLE"
PROFILE=""
SHOW_CONF="FALSE"

### Var

### Welcome
printf "Hello %s - Welcome to %s v%s\n" "$(whoami)" "$PROGRAM_NAME" "$PROGRAM_VERSION"

# Helpers
clean_up() {
    return
}

error_exit() {
    local l_error_message
    l_error_message="$1"

    printf "[ERROR] - %s\n" "${l_error_message:-'Unknown Error'}" >&2
    echo "Exiting with exit code 1"
    clean_up
    exit 1
}

graceful_exit() {
    clean_up
    exit 0
}

load_libraries() {
    for _ext_bin in $EXTERNAL_BINARIES; do
        if ! which "$_ext_bin" &>/dev/null; then
            error_exit "Required binary $_ext_bin not found."
        fi
    done
}

help_message() {
    cat <<-_EOF_

Description  : Git configure profile on local project.
               Advice: Create an alias to call it directly from everywhere

Example usage:
bash git-configurer.bash --list
bash git-configurer.bash -p profile_name_from_yaml_config

Options:
  [-h | --help]                      Display this help message
  [-v | --verbose]        (OPTIONAL) More verbose output
  [--trace]               (OPTIONAL) Set -o xtrace
  [-p | --profile]                   Specify profile to be used
  [--list]                           Show all profiles config available
_EOF_
    return
}

### Func
log_debug() {
    local l_message
    l_message="$1"

    if [ $LOG_LEVEL == "DEBUG" ]; then
        echo "[DEBUG] - $l_message"
    fi
}


ask_user_permission() {
    local l_message
    l_message="$1"

    printf "%s (y/n): " "$l_message"

    local l_continue
    read -r l_continue

    if [ "$l_continue" == "y" ]; then
        echo "OK"
    elif [ "$l_continue" == "n" ]; then
        graceful_exit
    else
        echo "Invalid choice [$l_continue]! Retrying..."
        ask_user_permission "$l_message"
    fi
}

check_non_corrupted_config() {
		# shellcheck disable=SC2002
		if cat ~/.git-configurer/config.yaml | yq -e . >/dev/null 2>&1; then
		  return 0
		fi
		error_exit "Configuration file is invalid or corrupted. Aborting..."
}

check_git_repo() {
  if git status >/dev/null 2>&1; then
    return 0
  fi
  error_exit "Not a git repo"
}

### Check binaries
load_libraries

### Parse args
while [[ -n "$1" ]]; do
    case "$1" in
    -h | --help)
        help_message
        graceful_exit
        ;;
    -v | --verbose)
        LOG_LEVEL="DEBUG"
        ;;
    --trace)
        set -o xtrace
        ;;
    -p | --profile)
        PROFILE=$2
        ;;
    --list)
        SHOW_CONF="TRUE"
        ;;
    --* | -*)
        usage >&2
        error_exit "Unknown option $1"
        ;;
    esac
    shift
done

### Checking args
if [ ! -f ~/.git-configurer/config.yaml ]; then
  error_exit "config file not found at location ~/.git-configurer/config.yaml"
fi
if [[ -z "$PROFILE" && "$SHOW_CONF" == "FALSE" ]]; then
  error_exit "profile - missing parameter"
fi

check_non_corrupted_config

### Main logic
# shellcheck disable=SC2002
_table_credentials="PROFILE USERNAME EMAIL "
# shellcheck disable=SC2002
_table_credentials+=$(cat ~/.git-configurer/config.yaml | yq eval '.profiles | to_entries | sort_by(.key)[] | "\(.key) \(.value.username) \(.value.email)"')

log_debug "$_table_credentials"

if [[ "$SHOW_CONF" == "TRUE" ]]; then
  # shellcheck disable=SC2059
  printf "${_table_credentials[@]}" | xargs -n3 | column -t -c 50
  graceful_exit
fi

check_git_repo

# shellcheck disable=SC2002
profile_check=$(cat ~/.git-configurer/config.yaml | yq .profiles."$PROFILE")
if [[ "$profile_check" != "null" ]]; then
  # shellcheck disable=SC2002
  username=$(cat ~/.git-configurer/config.yaml | yq .profiles."$PROFILE".username)
  # shellcheck disable=SC2002
  email=$(cat ~/.git-configurer/config.yaml | yq .profiles."$PROFILE".email)

  git config user.name "$username" &>/dev/null
  git config user.email "$email" &>/dev/null
  git config --list
  graceful_exit
else
  error_exit "No profile found"
fi
