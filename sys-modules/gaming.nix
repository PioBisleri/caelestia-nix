{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.gamemode.enable = true;


  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    lutris
    winetricks
    protonup-qt
    gamemode
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
}
