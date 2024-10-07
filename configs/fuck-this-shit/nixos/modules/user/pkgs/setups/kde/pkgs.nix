{config, lib, pkgs, ...}:

{
  packages = with pkgs; [
    kdePackages.plasma-browser-integration
    kdePackages.konsole
    kdePackages.oxygen
    telegram-desktop
  ];
}
