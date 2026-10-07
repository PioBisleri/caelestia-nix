{ config, pkgs, ... }: {

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

}
