#!/bin/sh

MEDIA_DIR="$HOME/media"
SAVE_DIR="$MEDIA_DIR/video-records"

_prepare_dirs() {
    mkdir -p $MEDIA_DIR
    mkdir -p $SAVE_DIR
}

full_save() {
    _prepare_dirs
    wf-recorder --audio="$(pactl get-default-sink).monitor" -c h264_vaapi -d /dev/dri/renderD128 -f "$SAVE_DIR/$(date +'%s_video.mp4')"
}

region_save() {
    _prepare_dirs
    wf-recorder -g "$(slurp)" --audio="$(pactl get-default-sink).monitor" -c h264_vaapi -d /dev/dri/renderD128 -f "$SAVE_DIR/$(date +'%s_video.mp4')"
}

kill_records() {
    killall -s SIGINT wf-recorder
}

case $1 in
    "full-save")
        full_save
        ;;
    "region-save")
        region_save
        ;;
    "kill-records")
        kill_records
        ;;
    *)
        echo "Error :D"
        ;;
esac
