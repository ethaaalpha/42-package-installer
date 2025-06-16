#!/bin/bash
set -e

function define_login_service {
    mkdir -p ~/.config/systemd/user

    cat <<EOF > ~/.config/systemd/user/login.service

[Unit]
Description=Download sgoinfre to goinfre

[Service]
Type=oneshot
ExecStart=mkdir -p "$1" && rsync -av "$2" "$1"

[Install]
WantedBy=default.target
EOF
}

function define_logout_service {
    mkdir -p ~/.config/systemd/user

    cat <<EOF > ~/.config/systemd/user/logout.service

[Unit]
Description=Copy sgoinfre to goinfre

[Service]
Type=oneshot
ExecStart=rsync -av "$1" "$2"

[Install]
WantedBy=exit.target
EOF
}

if [ "$#" -ne 2 ]; then
    echo "./configure.sh <local_goinfre_directory> <remote_sgoinfre_directory>"
else
    define_login_service "$1" "$2"
    define_logout_service "$1" "$2"
    systemctl --user daemon-reload
    systemctl --user enable login.service
    systemctl --user enable logout.service
    echo "Successfully configured!"
fi
