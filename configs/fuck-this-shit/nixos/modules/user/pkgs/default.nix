{ config, lib, pkgs, ... }:

# Setups:
#   - river
#   - kde
let
  setup_name = "kde";
  setup_file = ./setups/${setup_name};
  setup_pkg = import "${setup_file}/pkgs.nix" { inherit config lib pkgs; };
in
{
  imports = [
    setup_file
  ];

  users.users.wh173h4nd = {
    packages = with pkgs; [
      # system
      wl-clipboard
      xwayland

      # utils
      aria2
      qrencode
      yt-dlp
      android-tools
      btop

      # soc
      element-desktop

      # media
      libresprite
      ffmpeg-full
      gimp
      cmus
      mpv

      # game
      unnethack

      # tools
      neovim
      tmux
      qemu
      nnn
      emacs-gtk

      # dev
      gdb
      git
      clang
      gnumake
      python3
      clang-tools
      zig

      # libs
      raylib
      
      # docs
      man-pages-posix
      linux-manual
      stdman

      # osint
      #gqrx
      maltego
      nmap

      # reverse
      binwalk
      radare2
      cutter

      # other
      pfetch
      figlet
    ] ++ setup_pkg.packages;
  };
  documentation.dev.enable = true;
}
