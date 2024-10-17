{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/Moscow";

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

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = ["wh173h4nd"];
    keepEnv = true; 
    persist = true; 
  }];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
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

}
