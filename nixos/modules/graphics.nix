{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ rocmPackages.clr.icd amdvlk ];
  };
}
