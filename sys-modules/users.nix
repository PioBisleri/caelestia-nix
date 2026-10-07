{ config, pkgs, vars, ... }: {

  users.users."${vars.username}" = {
    isNormalUser = true;
    description = vars.fullName;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;

}
