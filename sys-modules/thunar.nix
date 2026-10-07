{ config, pkgs, vars, ... }: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  users.groups.plugdev = {};
  users.users."${vars.username}".extraGroups = [ "plugdev" ];

  services.udev.extraRules = ''
    ENV{ID_MTP_DEVICE}=="1", MODE="0660", GROUP="plugdev"
    ENV{ID_MEDIA_PLAYER}=="1", MODE="0660", GROUP="plugdev"
  '';
}
