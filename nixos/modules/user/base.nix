{ config, lib, pkgs, ... }:

{
  users.users.wh173h4nd = {
    isNormalUser = true;
    description = "wh173h4nd";
    extraGroups = [ "networkmanager" "wheel" "video" "wh173h4nd" ];
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
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
  
}
