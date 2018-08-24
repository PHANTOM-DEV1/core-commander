#!/usr/bin/env bash

explorer_install ()
{
    ascii

    heading "Installing PHANTOM Explorer..."

    sudo mkdir "$EXPLORER_DIR" >> "$commander_log" 2>&1
    sudo chown "$USER":"$USER" "$EXPLORER_DIR" >> "$commander_log" 2>&1

    git clone "$EXPLORER_REPO" "$EXPLORER_DIR" | tee -a "$commander_log"
    cd "$EXPLORER_DIR"

    info "Installing dependencies..."
    yarn install | tee -a "$commander_log"
    success "Installed dependencies!"

    info "Building..."
    yarn build:"$CORE_NETWORK" | tee -a "$commander_log"
    success "Building!"

    success "Installed PHANTOM Explorer!"
}

explorer_uninstall ()
{
    ascii

    explorer_stop

    heading "Uninstalling PHANTOM Explorer..."

    sudo rm -rf "$EXPLORER_DIR"

    success "Uninstalled PHANTOM Explorer!"
}

explorer_update ()
{
    ascii

    cd "$EXPLORER_DIR"

    git fetch

    local origin=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    local remote_version=$(git rev-parse origin/"$origin")
    local local_version=$(git rev-parse HEAD)

    if [[ "$remote_version" == "$local_version" ]]; then
        STATUS_EXPLORER_UPDATE="No"

        info "You already have the latest PHANTOM Explorer version that we support."
    else
        STATUS_EXPLORER_UPDATE="Yes"

        read -p "An update is available for PHANTOM Explorer, do you want to install it? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            explorer_stop

            heading "Starting Update..."
            git reset --hard | tee -a "$commander_log"
            git pull | tee -a "$commander_log"
            success "Update OK!"

            explorer_start

            STATUS_EXPLORER_UPDATE="No"
        fi
    fi
}

explorer_start ()
{
    ascii

    heading "Starting Explorer..."

    EXPLORER_HOST="0.0.0.0" EXPLORER_PORT=4200 pm2 start "$EXPLORER_DIR/express-server.js" --name phantom-explorer >> "$commander_log" 2>&1

    success "Started Explorer!"
}

explorer_restart ()
{
    ascii

    heading "Restarting Explorer..."

    pm2 restart phantom-explorer >> "$commander_log" 2>&1

    success "Restarted Explorer!"
}

explorer_stop ()
{
    ascii

    heading "Stopping Explorer..."

    pm2 stop phantom-explorer >> "$commander_log" 2>&1

    success "Stopped Explorer!"
}

explorer_logs ()
{
    clear
    echo -e "\n$(text_yellow " Use Ctrl+C to return to menu")\n"
    trap : INT

    pm2 logs phantom-explorer
}

explorer_status ()
{
    local status=$(pm2status "phantom-explorer" | awk '{print $10}')

    if [[ "$status" == "online" ]]; then
        STATUS_EXPLORER="On"
    else
        STATUS_EXPLORER="Off"
    fi
}
