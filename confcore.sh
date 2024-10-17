#!/usr/bin/env bash

 ############################################################################# 
#                                                                             #
#                GLWTS(Good Luck With That Shit) Public License               #
#              Copyright (c) Every-fucking-one, except the Author             #
#                                                                             #
#  Everyone is permitted to copy, distribute, modify, merge, sell, publish,   #
#  sublicense or whatever the fuck they want with this software but at their  #
#  OWN RISK.                                                                  #
#                                                                             #
#                               Preamble                                      #
#                                                                             #
#  The author has absolutely no fucking clue what the code in this project    #
#  does. It might just fucking work or not, there is no third option.         #
#                                                                             #
#                                                                             #
#                  GOOD LUCK WITH THAT SHIT PUBLIC LICENSE                    #
#     TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION, AND MODIFICATION        #
#                                                                             #
#    0. You just DO WHATEVER THE FUCK YOU WANT TO as long as you NEVER LEAVE  #
#  A FUCKING TRACE TO TRACK THE AUTHOR of the original product to blame for   #
#  or hold responsible.                                                       #
#                                                                             #
#  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER    #
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    #
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        #
#  DEALINGS IN THE SOFTWARE.                                                  #
#                                                                             #
#  Good luck and Godspeed.                                                    #
#                                                                             #
 ############################################################################# 

# Default values
DEFAULT_CONFIGS_DIR="configs"
DEFAULT_PRESETS_DIR="os-presets"
DEFAULT_MANIFEST_FILE="MANIFEST"


# Text styles
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Text colors
GREEN='\033[1;32m'
BLUE='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NO_COLOR='\033[0'
# Note: First, specify the color and only then the text style 

logo() {
    echo -e "${GREEN}${BOLD}"
    cat << 'EOF'
░█▀▀░█▀█░█▀█░█▀▀░█▀▀░█▀█░█▀▄░█▀▀
░█░░░█░█░█░█░█▀▀░█░░░█░█░█▀▄░█▀▀
░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀▀
EOF

    echo -e "${NO_COLOR}${NORMAL}"
}

about() {
    echo -e "
${YELLOW}${BOLD}What's that?${NORMAL}
This script is designed to deploy system settings and manage configuration files.
It has two modes of operation: ${BOLD}interactive${NORMAL} and ${BOLD}command line${NORMAL}. 

To run the script in interactive mode run the script without arguments:
    ${BOLD}./confcore.sh${NORMAL}

To run the script in command line mode, use arguments according to the following scheme:
    ${BOLD}./confcore.sh${NORMAL} ${BLUE}${BOLD}<commands>${NORMAL} ${GREEN}${BOLD}<args>${NORMAL}

    ${BLUE}${BOLD}Commands:${NORMAL}
        ${BOLD} * conf-deploy${NORMAL} - deploy configs(create symlinks) from manifest file
        ${BOLD} * conf-delete${NORMAL} - delete symlinks
        ${BOLD} * os-deploy${NORMAL} - deploy os preset
        ${BOLD} * os-gentempl${NORMAL} - generate template for os setup and presets
        ${BOLD} * about${NORMAL} - about this script

    ${GREEN}${BOLD}Args:${NORMAL}
        ${BOLD} * conf-deploy${NORMAL} - none
        ${BOLD} * conf-delete${NORMAL} - none
        ${BOLD} * os-deploy${NORMAL} - <os> <preset>
            <os> - OS config from ${BOLD}PRESETS_DIR${NORMAL} variable
            <preset> - preset from <os> config directory. If no preset is specified, only the basic configuration is installed
        ${BOLD} * os-gentempl${NORMAL} - none
        ${BOLD} * about${NORMAL} - none

${YELLOW}${BOLD}Global variables:${NORMAL}
    ${BOLD}* CONFIGS_DIR${NORMAL} - sets the directory where the configs are stored. Default: \"configs\"
    ${BOLD}* PRESETS_DIR${NORMAL} - sets the directory where OS presets are stored. Default: \"os-presets\"
    

${YELLOW}${BOLD}Manifest file:${NORMAL}
The manifest file (MANIFEST by default), located in the ${BOLD}CONFIGS_DIR${NORMAL} directory, describes
the rules for creating symbolic links for configuration/dotfiles.

${BOLD}Syntax and example:${NORMAL}

 +-----------------------------------------------------+
 | # comment bla-bla-bla                               |
 | \$HOME <- .zshrc .tmux.conf fuck-this-shit/.emacs.d  |
 | \$HOME/.config <- nvim                               |
 +-----------------------------------------------------+

As we can see, our manifest file supports comments that start with the ${BOLD}\"#\"${NORMAL} character.
Next we see the expression for symlink creation, which starts with the directory where
the symlinks should be created, the special character combination ${BOLD}\"<-\"${NORMAL} to create a symbolic
link, and a list of configuration files for which the links should be created, separated by spaces. 
In the left part of the expression it is allowed to use variables, for example \$HOME. 
In the right part of the expression all paths are calculated relative to ${BOLD}CONFIGS_DIR${NORMAL}.
Strings not containing ${BOLD}\"<-\"${NORMAL} will be ignored.


${YELLOW}${BOLD}OS customization and preset deployment:${NORMAL}
System configuration and deployment of presets is done from the configurations located in ${BOLD}PRESETS_DIR${NORMAL}.
A configuration is a regular directory, named, for example, by the name of a Linux distribution, in
which the base configuration file base.sh/base (priority: base.sh > base) and presets are located. 
If no preset is specified during installation, only the base configuration from base.sh/base is installed.
Only one preset can be installed at a time.

Templates for base.sh/base and presets can be generated using the ${BOLD}os-gentempl${NORMAL} function by selecting it from
the interactive menu or calling it from the command line.

The following functions must be defined in base.sh/base: ${BOLD}preinstall_phase, install_phase, postinstall_phase${NORMAL}.
In presets, the preset_phase function must be necessarily defined
${BOLD}Function call scheme:${NORMAL}
    ${BOLD}* without preset:${NORMAL} preinstall_phase -> install_phase -> postinstall_phase.
    ${BOLD}* with preset:${NORMAL} preinstall_phase -> install_phase -> preset_phase -> postinstall_phase.

${YELLOW}${BOLD}General scheme:${NORMAL}
${BOLD}
.
 |--confcore.sh
 \`--CONFIG_DIR(default: configs)
     |--MANIFEST  
     |--dotfile-1
     |--dotfile-2
     |--dotfile-n
     \`--PRESETS_DIR(default: os-presets)
         |--os-1
         |   |--base.sh
         |   \`--preset-1
         \`--os-2
             |--base
             |--preset-1
             \`--preset-2

${NORMAL}
${YELLOW}${BOLD}License:${NORMAL}
                                                                             
                GLWTS(Good Luck With That Shit) Public License               
              Copyright (c) Every-fucking-one, except the Author             
                                                                             
  Everyone is permitted to copy, distribute, modify, merge, sell, publish,   
  sublicense or whatever the fuck they want with this software but at their  
  OWN RISK.                                                                  
                                                                             
                               Preamble                                      
                                                                             
  The author has absolutely no fucking clue what the code in this project    
  does. It might just fucking work or not, there is no third option.         
                                                                             
                                                                             
                  GOOD LUCK WITH THAT SHIT PUBLIC LICENSE                    
     TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION, AND MODIFICATION        
                                                                             
    0. You just DO WHATEVER THE FUCK YOU WANT TO as long as you NEVER LEAVE  
  A FUCKING TRACE TO TRACK THE AUTHOR of the original product to blame for   
  or hold responsible.                                                       
                                                                             
  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER    
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER       
  DEALINGS IN THE SOFTWARE.                                                  
                                                                            
  Good luck and Godspeed.                                                    
    "
}


error() {
    echo -e "${RED}${BOLD}[ERROR]: $1${NORMAL}"
    echo -e "${BLUE}${BOLD}Backtrace: ${NORMAL}"
    echo -e "${BLUE}${BOLD}* END${NORMAL}"
    echo -e "${BLUE}${BOLD}^${NORMAL}"
    for (( i=0; i<${#FUNCNAME[@]}; i++ )); do
        echo -e "${BLUE}${BOLD}|${NORMAL}"
        echo -e "${BLUE}${BOLD}* file:${BASH_SOURCE[1]}\tfunc_call_line:${BASH_LINENO[$i]}\tfunc_name:${FUNCNAME[$i]}"
    done
    echo -e "${BLUE}${BOLD}|${NORMAL}"
    echo -e "${BLUE}${BOLD}* START${NORMAL}"
    exit 1
}

dotconf() {
    # Internal support functions(starts with underscore: _func_name)
    _create_symlink() {
        local targer_dir="$1"
        local conf_dir="$2"
        local conf_name="$3"

        if [ ! -e "$CONFIGS_DIR/$conf_dir/$conf_name" ]; then
            error "The config <$CONFIGS_DIR/$conf_dir/$conf_name> does not exist."
        fi

        if [ -e "$target_dir/$conf_name" ]; then
            echo -e "${YELLOW}${BOLD}[WARNING]: $conf_dir/$conf_name already exist. Maybe it's a symlink, file or directory.${NORMAL}"
            local choice=""
            read -p "${BOLD}Delete and symlink it?(yes/no)${NORMAL}: " choice
            case "$choice" in 
                "y"|"Y"|"yes"|"Yes"|"YES")
                    rm -rf "$target_dir/$conf_name"
                    ;;
                *)
                    return
                    ;;
            esac
        fi

        local output=$( { ln -s "$CONFIGS_DIR/$conf_dir/$conf_name" "$target_dir/$conf_name" 2>&1; echo $?; } )
        local exit_code=${output##*$'\n'}
        output=${output%$'\n'*}
        if [ $exit_code -ne 0 ]; then
            error "$output"
        fi
        echo -e "${GREEN}${BOLD}[OK]: $conf_dir/$conf_name --> $target_dir/$conf_name${NORMAL}"
    }

    _delete_symlink() {
        local target_dir="$1"
        local conf_dir="$2"
        local conf_name="$3"

        local output=$( { rm "$target_dir/$conf_name" 2>&1; echo $?; } )
        local exit_code=${output##*$'\n'}
        output=${output%$'\n'*}
        if [ $exit_code -ne 0 ]; then
            echo -e "${YELLOW}${BOLD}[WARNING]: $output${NORMAL}"
            return
        fi
        echo -e "${GREEN}${BOLD}[OK]: $conf_dir/$conf_name -!> $target_dir/$conf_name${NORMAL}"
    }

    _get_all_configs() {
        local confs=""
        for key in "${!dirs_and_confs[@]}"; do
            for conf in ${dirs_and_confs["$key"]}; do
                confs+="$(basename "$conf") "
            done
        done
        for element in $(ls -A "$1"); do
            if ! ([[  "$confs" =~ [[:space:]]"$element"[[:space:]] ]] ||
                [[ "$confs" =~ ^"$element"[[:space:]] ]] ||
                [[ "$confs" =~ [[:space:]]"$element"$ ]]); then
                if [ -d "$1/$element" ]; then
                    all_configs+=($element)
                    _get_all_configs "$1/$element"    
                else
                    all_configs+=($element)
                fi
            fi
        done
    }

    local operation=$1
    case $operation in 
        "conf-deploy")
            operation="_create_symlink"
            ;;
        "conf-delete")
            operation="_delete_symlink"
            ;;
        *)
            error "The operation <$operation> does not exist."
            ;;
    esac

    local manifest_file="$CONFIGS_DIR/$DEFAULT_MANIFEST_FILE"
    if [ ! -f "$manifest_file"  ]; then
        error "The manifest file <$manifest_file> does not exist."
    fi

    declare -A local dirs_and_confs
    IFS=$'\n'
    for row in $(<$manifest_file); do
        if [[ "$row" =~ ^#.* || ! "$row" == *"<-"* ]]; then
            continue
        fi
        local target_dir=$(eval echo $(echo "$row" | awk -F'<-' '{print $1}' | sed 's/^ *//; s/ *$//; s/"//g;') | sed 's/ /\\ /g')
        local confs=$(echo $row | awk -F'<-' '{print $2}' | sed 's/"//g;')
        dirs_and_confs["$target_dir"]="$confs"
    done 
    unset IFS

    for target_dir in "${!dirs_and_confs[@]}"; do
        for confs in ${dirs_and_confs["$target_dir"]}; do
            local conf_dir=$(dirname "$confs")
            local conf_name=$(basename "$confs")
            $operation "$target_dir" "$conf_dir" "$conf_name"
        done
    done

    local all_configs=()
    _get_all_configs "$CONFIGS_DIR"


    for dir in ${!dirs_and_confs[@]}; do
        for file in $(ls -A "$dir"); do
            if [ -L "$dir/$file" ]; then
                for key in ${!dirs_and_confs[@]}; do
                    local founded=false
                    for elem in ${dirs_and_confs["$key"]}; do
                        if [[ "$file" == "$(basename $elem)" ]]; then
                            founded=true
                        fi
                    done
                    if [ "$founded" == true ]; then
                        if [[ ! "$dir" == "$key" ]]; then 
                            _delete_symlink "$dir" "" "$file"
                        fi
                    fi
                done
                for conf in "${all_configs[@]}"; do
                    if [[ "$file" == "$conf" ]]; then
                        _delete_symlink "$dir" "" "$file"
                    fi
                done
            fi
        done
    done

}

osconf() {
    local mode=""
    case $1 in 
        "")
            mode="interactive"
            ;;
        *)
            mode="args"
            ;;
    esac

    if [ -z "$PRESETS_DIR"  ]; then
        PRESETS_DIR="$(realpath .)/$DEFAULT_CONFIGS_DIR/$DEFAULT_PRESETS_DIR"
    fi
    if [ ! -d "$PRESETS_DIR" ]; then
        error "The directory with configs <$PRESETS_DIR> does not exist."
    fi
    
    declare -A local os_and_presets
    for dir in $(ls -A "$PRESETS_DIR"); do
        os_and_presets["$dir"]="$(ls -A "$PRESETS_DIR/$dir/" | tr '\n' ' ' | sed 's/base.sh//g; s/base//g')"
    done

    local os=""
    local preset=""

    case $mode in
        "args")
            local args=($1)

            os="${args[0]}"
            if [ ! -e "$PRESETS_DIR/$os" ]; then
                error "The OS <$os> does not exist."
            fi

            preset="${args[1]}"
            if [ ! -e "$PRESETS_DIR/$os/$preset" ]; then
                error "The preset <$preset> in OS <$os> directory does not exist."
            fi
            ;;

        "interactive")
            clear
            echo -e "${YELLOW}${BOLD}Choose the OS: ${NORMAL}"
            for key in "${!os_and_presets[@]}"; do
                echo -e "${BOLD}* $key${NORMAL}"
            done
            read -p "${BOLD}OS${NORMAL}: " os
            if [[ ! -v os_and_presets["$os"] ]]; then
                error "The OS <$os> does not exist."
            fi
            
            clear
            echo -e "Leave the input field blank if you only want to install the basic configuration."
            echo -e "${YELLOW}${BOLD}Choose the preset: ${NORMAL}"
            for presets in "${os_and_presets["$os"]}"; do
                for preset in ${presets}; do
                    echo -e "${BOLD}* $preset${NORMAL}"
                done
            done
            read -p "${BOLD}Preset${NORMAL}: " preset
            if ! ([[  ${os_and_presets["$os"]} =~ [[:space:]]"$preset"[[:space:]] ]] ||
                [[ ${os_and_presets["$os"]} =~ ^"$preset"[[:space:]] ]] ||
                [[ ${os_and_presets["$os"]} =~ [[:space:]]"$preset"$ ]]) && 
                [[ ! ${os_and_presets["$os"]} == "" ]]; then
                error "The preset <$preset> in OS <$os> directory does not exist."
            fi
            ;;

        *)
            error "The mode <$mode> does not exist."
            ;;
    esac

    # base.sh > base
    echo "$PRESETS_DIR/$os/"
    local base_conf_file="$(find "$PRESETS_DIR/$os/" -maxdepth 1 -type f -name "base.sh" -o -name "base" | head -n1)"
    if [ ! -e "$base_conf_file" ]; then
        error "The base.sh/base config file in OS <$os> directory does not exist."

    fi

    source "$base_conf_file"
    if [ ! -z $preset ]; then
        source "$PRESETS_DIR/$os/$preset"
    fi

    local funcs=("preinstall_phase" "install_phase" "postinstall_phase")
    for func in ${funcs[@]}; do
        if ! declare -f $func > /dev/null; then
            error "The function <$func> in config file <$base_conf_file> does not exist. See about section."
        fi 
    done

    preinstall_phase
    install_phase

    if [ ! -z $preset ]; then
        if ! declare -f preset_phase > /dev/null; then
            error "The function <preset_phase> in config file <$PRESETS_DIR/$os/$preset> does not exist. See about section."
        fi 
        preset_phase
    fi
    postinstall_phase
}

gentempl() {
    if [ -z "$PRESETS_DIR"  ]; then
        PRESETS_DIR="$(realpath .)/$DEFAULT_CONFIGS_DIR/$DEFAULT_PRESETS_DIR"
    fi
    if [ ! -d "$PRESETS_DIR" ]; then
        clear
        echo -e "${YELLOW}${BOLD}[WARNING]: The directory with configs <$PRESETS_DIR> does not exist.${NORMAL}"
        local choice=""
        read -p "${BOLD}Create?(yes/no)${NORMAL}: " choice
        case "$choice" in 
            "y"|"Y"|"yes"|"Yes"|"YES")
                mkdir -p "$PRESETS_DIR"
                ;;
            *)
                error "The directory with configs <$PRESETS_DIR> does not exist."
                ;;
        esac
    fi

    clear
    echo -e "${YELLOW}${BOLD}Enter the OS name.${NORMAL}"
    local choice=""
    read -p "${BOLD}OS${NORMAL}: " choice
    mkdir -p "$PRESETS_DIR/$choice"

    echo "
 ################################################### 
#                                                   #
#     This file was generated using os-gentempl     #
#                                                   #
 ################################################### 

# Global variables
PACKAGES=()

preinstall_phase() {
# greeting, notice and etc 
}

install_phase() {
# package installing, configuration and etc 
}

postinstall_phase() {
# Goodbye, cleaning and etc
}
    " > "$PRESETS_DIR/$choice/base.sh"


    echo "
 ################################################### 
#                                                   #
#     This file was generated using os-gentempl     #
#                                                   #
 ################################################### 

# Add installation packages to the main configuration
PACKAGES+=()

preset_phase() {
# additional package installing, configuration and etc 
}
    " > "$PRESETS_DIR/$choice/preset_example.sh"
}

confcore() {
    logo

    declare -A local operations_and_desc
    operations_and_desc["conf-deploy"]="deploy configs(create symlinks) from manifest file"
    operations_and_desc["conf-delete"]="delete symlinks"
    operations_and_desc["os-deploy"]="deploy os preset"
    operations_and_desc["os-gentempl"]="generate template for os setup and presets"
    operations_and_desc["about"]="about this script"

    declare -A local operations_and_func
    operations_and_func["conf-deploy"]="dotconf conf-deploy"
    operations_and_func["conf-delete"]="dotconf conf-delete"
    operations_and_func["os-deploy"]="osconf"
    operations_and_func["os-gentempl"]="gentempl"
    operations_and_func["about"]="about"

    local operation=""
    local args=""

    if [ -z "$CONFIGS_DIR"  ]; then
        CONFIGS_DIR="$(realpath .)/$DEFAULT_CONFIGS_DIR"
    fi
    if [ ! -d "$CONFIGS_DIR" ]; then
        about
        error "The directory with configs <$CONFIGS_DIR> does not exist."
    fi

    case $# in
        "0")
            echo -e "${YELLOW}${BOLD}Select the operation: ${NORMAL}"
            for key in "${!operations_and_desc[@]}"; do
                echo -e "${BOLD}* $key${NORMAL} - ${operations_and_desc[$key]}"
            done
            read -p "${BOLD}Operation${NORMAL}: " operation
            ;;
        *)
            operation="$1"
            shift
            args="$@"
            ;;
    esac

    if [[ ! -v operations_and_func[$operation] ]]; then
        error "The operaton <$operation> does not exist."
    fi

    ${operations_and_func[$operation]} "$args"

}

confcore "$@"
