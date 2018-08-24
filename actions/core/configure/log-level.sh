#!/usr/bin/env bash

core_configure_log_level ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    read -p "Enter the log level, or press ENTER for the default [$PHANTOM_LOG_LEVEL]: " inputLevel

    if [[ ! -z "$inputLevel" ]]; then
        sed -i -e "s/PHANTOM_LOG_LEVEL=$PHANTOM_LOG_LEVEL/PHANTOM_LOG_LEVEL=$inputLevel/g" "$envFile"
    fi

    . "$envFile"
}
