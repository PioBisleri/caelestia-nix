{ config, pkgs, inputs, vars, ... }: {

  home.stateVersion = "26.05";

  imports = [
    inputs.areofyl-fetch.homeManagerModules.default
    inputs."caelestia-shell".homeManagerModules.default
    ./hm-modules/packages.nix
    ./hm-modules/default-apps.nix
    ./hm-modules/zsh.nix
    ./hm-modules/git.nix
    ./hm-modules/gtk.nix
    ./hm-modules/services.nix
    ./hm-modules/hyprland.nix
    ./hm-modules/scripts.nix
    ./hm-modules/caelestia.nix
    ./hm-modules/matugen.nix
    ./hm-modules/fuzzel.nix
    ./hm-modules/kitty.nix
    ./hm-modules/qt6ct.nix
    ./hm-modules/secrets.nix
  ];

}
