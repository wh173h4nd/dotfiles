# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:


# sudo nix-channel --add https://nixos.org/channels/nixos-unstable
# sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# sudo nix-channel --update
{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  xdg.portal = {
	  enable = true;
	  wlr = {
		  enable = true;
	  };
	  config = {
		  common = {
			  default = [ "gtk" ];
	  };
	  };
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ rocmPackages.clr.icd amdvlk ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
  };

  networking.hostName = "lain-systems"; # Define your hostname.
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Doas
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = ["lifes4crifice"];
    keepEnv = true; 
    persist = true; 
  }];

  # Cross-compiling
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lifes4crifice = {
    isNormalUser = true;
    description = "lifes4crifice";
    extraGroups = [ "networkmanager" "wheel" "video" "lifes4crifice" ];
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # system
		wl-clipboard
		brightnessctl
    wf-recorder
    pulseaudio
		xwayland
    ntfs3g
		gnupg
		slurp
		foot
		grim

    # utils
		wget
		curl 
		aria2
    ncftp
		pfetch
    killall
		inetutils
		yt-dlp
		btop
    dig
    libva-utils
      

    # media
		libresprite
    ffmpeg-full
		zathura
		gimp
		cmus
		mpv
		imv

    # game
		unnethack

    # tools
		neovim
    file
		tmux
    qemu
		ranger
		emacs-gtk
		android-tools

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
		man-pages
		stdman

    # osint
    gqrx
    maltego
    nmap

    # reverse
		binwalk
    radare2
    cutter


    # others
		figlet

  ];
  documentation.dev.enable = true;

  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
  	enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      sudo = "doas ";
      em = "emacsclient -nw ";
      nv = "nvim ";
    };
	  ohMyZsh = {
		  enable = true;
		  plugins = [ "git" "vi-mode" "man" ];
		  theme = "bureau";
	  };
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ibm-plex
      terminus_font
      terminus_font_ttf
    ];

	  fontconfig = {
		  enable = true;
		  defaultFonts = {
			  serif = [  "IBM Plex Serif" ];
			  sansSerif = [ "IBM Plex Sans" ];
			  monospace = [ "IBM Plex Mono" ];
		  };
		  antialias = true;
		  subpixel = {
			  rgba = "rgb";
			  lcdfilter = "default";
		  };
		  hinting = {
			  enable = true;
			  style = "medium";
			  #autohint = true;
		  };
	  };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    preferences = {
      "browser.uidensity" = 1;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.policy.firstRunURL" = "";
    };
  };

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

