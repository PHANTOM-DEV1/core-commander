#!/usr/bin/env bash

menu_manage_core_help ()
{
    ascii

    divider

    text_yellow "    Update PHANTOM (U)"
    text_white "    update PHANTOM core if a new version is available."
    echo

    text_yellow "    Uninstall PHANTOM (P)"
    text_white "    uninstall PHANTOM Core from your system."
    echo

    text_yellow "    Configure PHANTOM (C)"
    text_white "    lets you select a network configuration and automatically creates the database for the config you chose."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head on over to https://docs.phantom.io/"
    echo

    press_to_continue

    menu_main
}
