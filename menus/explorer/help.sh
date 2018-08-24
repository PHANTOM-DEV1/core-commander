#!/usr/bin/env bash

menu_manage_explorer_help ()
{
    ascii

    text_yellow "    Install PHANTOM Explorer (I)"
    text_white "    installs the PHANTOM blockchain explorer on your server."
    echo

    text_yellow "    Start PHANTOM Explorer (S)"
    text_white "    starts the PHANTOM blockchain explorer process (only visible if you have PHANTOM explorer installed)."
    echo

    text_yellow "    Show Log (L)"
    text_white "    shows the PM2 explorer process log."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head over to https://phantomdocs.readme.io/"
    echo

    press_to_continue

    menu_main
}
