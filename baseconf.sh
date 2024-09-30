#!/bin/sh

HOME_CONFS=( .emacs.d .tmux.conf )
DOT_CONFIG_CONFS=( nvim )

CONFIGS=(HOME_CONFS DOT_CONFIG_CONFS)
CURRENT_PATH=$(realpath .)
CONFIGS_DIR="$CURRENT_PATH/configs"

HOME_DIR=$HOME
DOT_CONFIG_DIR="$HOME_DIR/.config"

# text style
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# color codes 
GREEN='\033[1;32m'
BLUE='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NO_COLOR='\033[0'

logo() {
    echo -e "${BOLD}${GREEN}"
    cat << 'EOF'
              888       d88 888888 ,8,"88b, 888       d 888               888 
Y8b Y8b Y888P 888 ee   d888     ,e  " ,88P' 888 ee   d8 888  888 8e   e88 888 
 Y8b Y8b Y8P  888 88b d"888   ,eP     C8K   888 88b d88 888e 888 88b d888 888 
  Y8b Y8b "   888 888   888 ,e8P    e `88b, 888 888 """ 888" 888 888 Y888 888 
   YP  Y8P    888 888   888 88P    "8",88P' 888 888     888  888 888  "88 888 
EOF

    echo -e "${NORMAL}${NO_COLOR}"
}

help_message() {
    logo
    echo -e "
${BOLD}Usage:${NORMAL}
    ${BOLD}baseconf.sh${NORMAL} [command]
${BOLD}Commands:${NORMAL}
    ${BOLD}deploy${NORMAL} - deploy configs(create symlinks)
    ${BOLD}delete${NORMAL} - delete symlinks
    ${BOLD}help${NORMAL} - print this message
    "
}

_create_symlink() {
    echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Creating syslink for ${BOLD}$config${NORMAL}..."
    ln -s $CONFIGS_DIR/$2 $1/$2
    echo -e "${BOLD}${GREEN}OK:${NORMAL} Syslink for ${BOLD}$config${NORMAL} created!"
    echo ""
}

_delete_symlink() {
    echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Removing syslink for ${BOLD}$config${NORMAL}..."
    rm $1/$2
    echo -e "${BOLD}${GREEN}OK:${NORMAL} Syslink for ${BOLD}$config${NORMAL} removed!"
    echo ""
}

baseconf() {
    logo
    for conf_dir in "${CONFIGS[@]}"; do
        eval "direct=(\"\${$conf_dir[@]}\")"
        for config in "${direct[@]}"; do

            declare DIR 
            if [[ "$conf_dir" = "HOME_CONFS" ]]; then
                DIR=$HOME_DIR
            elif [[ "$conf_dir" = "DOT_CONFIG_CONFS" ]]; then
                DIR=$DOT_CONFIG_DIR
            fi

            if [[ "$1" = "deploy" ]]; then
                _create_symlink $DIR $config
            elif [[ "$1" = "delete" ]]; then
                _delete_symlink $DIR $config
            fi

        done
    done
}

case $1 in
    "deploy")
        baseconf deploy
        ;;
    "delete")
        baseconf delete
        ;;
    "help")
        help_message
        ;;
    *)
        help_message
        ;;
esac
