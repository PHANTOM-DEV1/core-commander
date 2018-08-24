#!/usr/bin/env bash

core_update ()
{
    ascii

    cd "$CORE_DIR"

    git fetch

    local origin=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    local remote_version=$(git rev-parse origin/"$origin")
    local local_version=$(git rev-parse HEAD)

    if [[ "$remote_version" == "$local_version" ]]; then
        STATUS_CORE_UPDATE="No"

        info "You already have the latest PHANTOM Core version that we support."
    else
        STATUS_CORE_UPDATE="Yes"

        read -p "An update is available for PHANTOM Core, do you want to install it? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            relay_status
            forger_status

            local relay_on=$STATUS_RELAY
            local forger_on=$STATUS_FORGER

            if [[ "$relay_on" = "On" ]]; then
                relay_stop
            fi

            if [[ "$forger_on" = "On" ]]; then
                forger_stop
            fi

            heading "Starting Update..."
            git reset --hard | tee -a "$commander_log"
            git checkout develop | tee -a "$commander_log"
            git pull | tee -a "$commander_log"
            lerna bootstrap

            if [[ "$relay_on" = "On" ]]; then
                relay_start
            fi

            if [[ "$forger_on" = "On" ]]; then
                forger_start
            fi

            success "Update OK!"
            STATUS_CORE_UPDATE="No"
        fi
    fi
}
