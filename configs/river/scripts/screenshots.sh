#!/bin/sh

MEDIA_DIR="$HOME/media"
SAVE_DIR="$MEDIA_DIR/screenshots"

_prepare_dirs() {
    mkdir -p $MEDIA_DIR
    mkdir -p $SAVE_DIR
}

full_copy() {
    grim - | wl-copy
}

region_copy() {
    grim -g "$(slurp)" - | wl-copy
}

full_save() {
    _prepare_dirs
    grim "$SAVE_DIR/$(date +'%s_scrsht.png')"
}

region_save() {
    _prepare_dirs
    grim -g "$(slurp)" "$SAVE_DIR/$(date +'%s_scrsht.png')"
}

case $1 in
    "full-copy")
        full_copy
        ;;
    "region-copy")
        region_copy
        ;;
    "full-save")
        full_save
        ;;
    "region-save")
        region_save
        ;;
    *)
        echo "Error :D"
        ;;
esac
