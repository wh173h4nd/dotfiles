#!/bin/sh

HOME_CONFS=( .emacs.d .tmux.conf )
CONFIG_CONFS=( foot river nvim )

CURRENT_PATH=$(realpath .)
CONF_DIR="$CURRENT_PATH/configs"

HOME_DIR=$HOME
CONFIG_DIR="$HOME_DIR/.config"

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
    ${BOLD}deploy.sh${NORMAL} [command]
${BOLD}Commands:${NORMAL}
    ${BOLD}deploy-configs${NORMAL} - deploy configs(create symlinks)
    ${BOLD}save-configs${NORMAL} - save configs
    ${BOLD}delete-configs${NORMAL} - delete symlinks
    ${BOLD}help${NORMAL} - print this message
    "
}

save_configs() {
    # home
    for conf in ${HOME_CONFS[@]}; do
            echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Copying config for ${BOLD}$conf${NORMAL}..."
            cp -r $HOME_DIR/$conf $CONF_DIR/$conf
            echo -e "${BOLD}${GREEN}OK:${NORMAL} Config for ${BOLD}$conf${NORMAL} copyed!"
            echo ""
    done;
    
    # home/.configs
    for conf in ${CONFIG_CONFS[@]}; do
            echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Copying config for ${BOLD}$conf${NORMAL}..."
            cp -r $CONFIG_DIR/$conf $CONF_DIR/$conf
            echo -e "${BOLD}${GREEN}OK:${NORMAL} Config for ${BOLD}$conf${NORMAL} copyed!"
            echo ""
    done;
}

deploy_configs() {
    logo

    # home
    for conf in ${HOME_CONFS[@]}; do
            echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Creating syslink for ${BOLD}$conf${NORMAL}..."
            ln -s $CONF_DIR/$conf $HOME_DIR/$conf
            echo -e "${BOLD}${GREEN}OK:${NORMAL} Syslink for ${BOLD}$conf${NORMAL} created!"
            echo ""
    done;

    mkdir -p $CONFIG_DIR
    # home/.configs
    for conf in ${CONFIG_CONFS[@]}; do
            echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Creating syslink for ${BOLD}$conf${NORMAL}..."
            ln -s $CONF_DIR/$conf $CONFIG_DIR/$conf
            echo -e "${BOLD}${GREEN}OK:${NORMAL} Syslink for ${BOLD}$conf${NORMAL} created!"
            echo ""
    done;
}

delete_configs() {
    # home
    for conf in ${HOME_CONFS[@]}; do
            echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Removing syslink for ${BOLD}$conf${NORMAL}..."
            rm $HOME_DIR/$conf
            echo -e "${BOLD}${GREEN}OK:${NORMAL} Syslink for ${BOLD}$conf${NORMAL} removed!"
            echo ""
    done;

    # home/.configs
    for conf in ${CONFIG_CONFS[@]}; do
            echo -e "${BOLD}${YELLOW}INFO:${NORMAL} Removing syslink for ${BOLD}$conf${NORMAL}..."
            rm $CONFIG_DIR/$conf
            echo -e "${BOLD}${GREEN}OK:${NORMAL} Syslink for ${BOLD}$conf${NORMAL} removed!"
            echo ""
    done;
}

case $1 in
    "deploy-configs")
        deploy_configs
        ;;
    "help")
        help_message
        ;;
    "save-configs")
        save_configs
        ;;
    "delete-configs")
        delete_configs
        ;;
    *)
        help_message
        ;;
esac
