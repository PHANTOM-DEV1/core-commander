#!/usr/bin/env bash

core_configure_database ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    read -p "Enter the database host, or press ENTER for the default [$PHANTOM_DB_HOST]: " inputHost
    read -p "Enter the database username, or press ENTER for the default [$PHANTOM_DB_USERNAME]: " inputUsername
    read -p "Enter the database password, or press ENTER for the default [$PHANTOM_DB_PASSWORD]: " inputPassword
    read -p "Enter the database name, or press ENTER for the default [phantom_${CORE_NETWORK}]: " inputDatabase

    if [[ ! -z "$inputHost" ]]; then
        sed -i -e "s/PHANTOM_DB_HOST=$PHANTOM_DB_HOST/PHANTOM_DB_HOST=$inputHost/g" "$envFile"
    fi

    if [[ ! -z "$inputUsername" ]]; then
        sed -i -e "s/PHANTOM_DB_USERNAME=$PHANTOM_DB_USERNAME/PHANTOM_DB_USERNAME=$inputUsername/g" "$envFile"
    fi

    if [[ ! -z "$inputPassword" ]]; then
        sed -i -e "s/PHANTOM_DB_PASSWORD=$PHANTOM_DB_PASSWORD/PHANTOM_DB_PASSWORD=$inputPassword/g" "$envFile"
    fi

    if [[ ! -z "$inputDatabase" ]]; then
        sed -i -e "s/PHANTOM_DB_DATABASE=$PHANTOM_DB_DATABASE/PHANTOM_DB_DATABASE=$inputDatabase/g" "$envFile"
    fi

    . "$envFile"
}
