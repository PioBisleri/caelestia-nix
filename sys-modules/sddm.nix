{ config, pkgs, ... }:

let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };

in {

  services.displayManager.sddm = {
    autoNumlock = true;
    enableHidpi = true;
    extraPackages = with pkgs; [
      custom-sddm-astronaut
    ];
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
        CursorTheme = "Bibata-Modern-Classic";
        CursorSize = 24;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors
    custom-sddm-astronaut
    kdePackages.qtmultimedia
  ];

}
