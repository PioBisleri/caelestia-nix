{ config, pkgs, vars, inputs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./sys-modules/base.nix
    ./sys-modules/display.nix
    ./sys-modules/audio.nix
    ./sys-modules/hardware.nix
    ./sys-modules/users.nix
    ./sys-modules/packages.nix
    ./sys-modules/sddm.nix
    ./sys-modules/gaming.nix
    ./sys-modules/secrets.nix
    ./sys-modules/thunar.nix
  ];

}
