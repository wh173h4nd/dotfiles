# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable
# sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# sudo nix-channel --update
let
  state_version = "24.05";
in
{

  imports =
    [ # Include the results of the hardware scan.
      ./modules/hardware-configuration.nix
      ./modules/nix-settings.nix
      ./modules/boot.nix
      ./modules/graphics.nix
      ./modules/bluetooth.nix
      ./modules/i18n.nix
      ./modules/networking.nix
      ./modules/sound.nix
      ./modules/xserver.nix
      ./modules/general.nix
      ./modules/pkgs
      ./modules/user
    ];

  system.stateVersion = state_version; 
}

