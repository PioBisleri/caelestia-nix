{ config, pkgs, vars, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.sshKeyPaths = [ "/home/${vars.username}/.ssh/id_ed25519" ];
    defaultSopsFile = ../secrets/user.yaml;
    secrets = {};
  };
}
