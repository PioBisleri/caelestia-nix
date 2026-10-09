{ config, pkgs, lib, ... }: {

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;

  # The Hyprland package ships a second "Hyprland (uwsm-managed)" session file
  # that starts the compositor through systemd and black-screens with this rice.
  # SDDM sorts it before the plain session (hyprland-uwsm < hyprland), so on any
  # state reset it becomes the preselected target. Replace the package in the
  # DM's session list with a wrapper that exposes only the plain session file.
  services.displayManager.sessionPackages = lib.mkForce [
    ((pkgs.runCommand "hyprland-sessions-only" { } ''
       mkdir -p "$out/share/wayland-sessions"
       ln -s ${config.programs.hyprland.package}/share/wayland-sessions/hyprland.desktop \
             "$out/share/wayland-sessions/hyprland.desktop"
     '') // {
       providedSessions = [ "hyprland" ];
     })
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "hyprland" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

}