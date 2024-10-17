{ config, lib, pkgs, ... }:

{
  packages = with pkgs; [
    # system
    pulseaudio

    # utils
    brightnessctl
    wf-recorder
    libva-utils
    slurp
    grim

    # GUI fm
    pcmanfm
    
    # Term
    foot

    # Docs reader
    zathura

    # Image viewer
    imv
  ];
}
