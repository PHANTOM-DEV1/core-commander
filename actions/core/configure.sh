#!/usr/bin/env bash

core_configure ()
{
    ascii

    local configured=false

    if [[ -d "$CORE_CONFIG" ]]; then
        read -p "We found an PHANTOM Core configuration, do you want to overwrite it? [y/N] : " choice

        if [[ "$choice" =~ ^(yes|y|Y) ]]; then
            __core_configure_pre

            rm -rf "$CORE_CONFIG"

            __core_configure_network

            core_configure_database

            __core_configure_post

            configured=true
        else
            warning "Skipping configuration..."
        fi
    else
        __core_configure_pre

        __core_configure_network

        core_configure_database

        __core_configure_post

        configured=true
    fi

    if [[ "$configured" = true ]]; then
        read -p "PHANTOM Core has been configured, would you like to start the relay? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            relay_start
        fi
    fi
}

__core_configure_pre ()
{
    if [[ "$STATUS_RELAY" = "On" ]]; then
        relay_stop
    fi

    if [[ "$STATUS_FORGER" = "On" ]]; then
        forger_stop
    fi
}

__core_configure_post ()
{
    database_create
}

__core_configure_network ()
{
    info "Which network would you like to configure?"

    # validNetworks=("mainnet" "devnet" "testnet")
    validNetworks=("devnet" "testnet")

    select opt in "${validNetworks[@]}"; do
        case "$opt" in
            # "mainnet")
            #     __core_configure_core "mainnet"
            #     __core_configure_commander "mainnet"
            #     __core_configure_environment "mainnet"
            #     break
            # ;;
            "devnet")
                __core_configure_core "devnet"
                __core_configure_commander "devnet"
                __core_configure_environment "devnet"
                break
            ;;
            "testnet")
                __core_configure_core "testnet"
                __core_configure_commander "testnet"
                __core_configure_environment "testnet"
                break
            ;;
            *)
                echo "Invalid option $REPLY"
            ;;
        esac
    done

    . "$commander_config"
}

__core_configure_core ()
{
    if [[ ! -d "$CORE_DATA" ]]; then
        mkdir "$CORE_DATA"
    fi

    cp -r "${CORE_DIR}/packages/core/lib/config/$1" "$CORE_CONFIG"
}

__core_configure_commander ()
{
    sed -i -e "s/CORE_NETWORK=$CORE_NETWORK/CORE_NETWORK=$1/g" "$commander_config"
}

__core_configure_environment ()
{
    heading "Creating Environment configuration..."

    local envFile="${CORE_DATA}/.env"

    touch "$envFile"

    grep -q '^PHANTOM_P2P_HOST' "$envFile" 2>&1 || echo 'PHANTOM_P2P_HOST=0.0.0.0' >> "$envFile" 2>&1

    if [[ "$1" = "testnet" ]]; then
        grep -q '^PHANTOM_P2P_PORT' "$envFile" 2>&1 || echo 'PHANTOM_P2P_PORT=4000' >> "$envFile" 2>&1
    fi

    # if [[ "$1" = "mainnet" ]]; then
    #     echo "PHANTOM_P2P_PORT=4001" >> "$envFile" 2>&1
    # fi

    if [[ "$1" = "devnet" ]]; then
        grep -q '^PHANTOM_P2P_PORT' "$envFile" 2>&1 || echo 'PHANTOM_P2P_PORT=4002' >> "$envFile" 2>&1
    fi

    grep -q '^PHANTOM_API_HOST' "$envFile" 2>&1 || echo 'PHANTOM_API_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^PHANTOM_API_PORT' "$envFile" 2>&1 || echo 'PHANTOM_API_PORT=4003' >> "$envFile" 2>&1

    grep -q '^PHANTOM_WEBHOOKS_HOST' "$envFile" 2>&1 || echo 'PHANTOM_WEBHOOKS_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^PHANTOM_WEBHOOKS_PORT' "$envFile" 2>&1 || echo 'PHANTOM_WEBHOOKS_PORT=4004' >> "$envFile" 2>&1

    grep -q '^PHANTOM_GRAPHQL_HOST' "$envFile" 2>&1 || echo 'PHANTOM_GRAPHQL_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^PHANTOM_GRAPHQL_PORT' "$envFile" 2>&1 || echo 'PHANTOM_GRAPHQL_PORT=4005' >> "$envFile" 2>&1

    grep -q '^PHANTOM_JSONRPC_HOST' "$envFile" 2>&1 || echo 'PHANTOM_JSONRPC_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^PHANTOM_JSONRPC_PORT' "$envFile" 2>&1 || echo 'PHANTOM_JSONRPC_PORT=8080' >> "$envFile" 2>&1

    grep -q '^PHANTOM_REDIS_HOST' "$envFile" 2>&1 || echo 'PHANTOM_REDIS_HOST=localhost' >> "$envFile" 2>&1
    grep -q '^PHANTOM_REDIS_PORT' "$envFile" 2>&1 || echo 'PHANTOM_REDIS_PORT=6379' >> "$envFile" 2>&1

    success "Created Environment configuration!"
}
