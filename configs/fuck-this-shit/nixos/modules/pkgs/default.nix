{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # system
    ntfs3g

    # utils
		inetutils
    killall
		gnupg
    ncftp
		wget
		curl 
    file
    dig
    jq

    # vpn and etc
    xray

    # docs
    man-pages
  ];
}
