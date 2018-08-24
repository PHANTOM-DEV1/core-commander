#!/usr/bin/env bash

core_configure_hosts_and_ports ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    # @phantomcore/core-p2p
    read -p "Would you like to configure the P2P API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the P2P API host, or press ENTER for the default [${PHANTOM_P2P_HOST}]: " inputHost
        read -p "Enter the P2P API port, or press ENTER for the default [${PHANTOM_P2P_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/PHANTOM_P2P_HOST=$PHANTOM_P2P_HOST/PHANTOM_P2P_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/PHANTOM_P2P_PORT=$PHANTOM_P2P_PORT/PHANTOM_P2P_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @phantomcore/core-api
    read -p "Would you like to configure the Public API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Public API host, or press ENTER for the default [${PHANTOM_API_HOST}]: " inputHost
        read -p "Enter the Public API port, or press ENTER for the default [${PHANTOM_API_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/PHANTOM_API_HOST=$PHANTOM_API_HOST/PHANTOM_API_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/PHANTOM_API_PORT=$PHANTOM_API_PORT/PHANTOM_API_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @phantomcore/core-webhooks
    read -p "Would you like to configure the Webhooks API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Webhooks API host, or press ENTER for the default [${PHANTOM_WEBHOOKS_HOST}]: " inputHost
        read -p "Enter the Webhooks API port, or press ENTER for the default [${PHANTOM_WEBHOOKS_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/PHANTOM_WEBHOOKS_HOST=$PHANTOM_WEBHOOKS_HOST/PHANTOM_WEBHOOKS_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/PHANTOM_WEBHOOKS_PORT=$PHANTOM_WEBHOOKS_PORT/PHANTOM_WEBHOOKS_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @phantomcore/core-graphql
    read -p "Would you like to configure the GraphQL API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the GraphQL API host, or press ENTER for the default [${PHANTOM_GRAPHQL_HOST}]: " inputHost
        read -p "Enter the GraphQL API port, or press ENTER for the default [${PHANTOM_GRAPHQL_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/PHANTOM_GRAPHQL_HOST=$PHANTOM_GRAPHQL_HOST/PHANTOM_GRAPHQL_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/PHANTOM_GRAPHQL_PORT=$PHANTOM_GRAPHQL_PORT/PHANTOM_GRAPHQL_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @phantomcore/core-json-rpc
    read -p "Would you like to configure the JSON-RPC API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the JSON-RPC host, or press ENTER for the default [${PHANTOM_JSONRPC_HOST}]: " inputHost
        read -p "Enter the JSON-RPC port, or press ENTER for the default [${PHANTOM_JSONRPC_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/PHANTOM_JSONRPC_HOST=$PHANTOM_JSONRPC_HOST/PHANTOM_JSONRPC_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/PHANTOM_JSONRPC_PORT=$PHANTOM_JSONRPC_PORT/PHANTOM_JSONRPC_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @phantomcore/core-*
    read -p "Would you like to configure redis? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Redis host, or press ENTER for the default [${PHANTOM_REDIS_HOST}]: " inputHost
        read -p "Enter the Redis port, or press ENTER for the default [${PHANTOM_REDIS_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/PHANTOM_REDIS_HOST=$PHANTOM_REDIS_HOST/PHANTOM_REDIS_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/PHANTOM_REDIS_PORT=$PHANTOM_REDIS_PORT/PHANTOM_REDIS_PORT=$inputPort/g" "$envFile"
        fi
    fi
}
