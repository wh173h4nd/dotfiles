{ config, lib, pkgs, ... }:

{
  programs.river = {
    enable = true;
    package = pkgs.river;
    xwayland.enable = true;
    extraPackages = with pkgs; [ bemenu sandbar swaylock ];
  };

  services.displayManager.ly = {
    enable = true;
    package = pkgs.ly;
    settings = {
      animation = "matrix";
      vi_mode = true;
      session_log = "/dev/null";
      initial_info_text = "Close the world... Open the next...";
    };
  };
}
