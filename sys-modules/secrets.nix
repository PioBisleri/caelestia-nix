{ config, pkgs, vars, inputs, ... }: {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    age.sshKeyPaths = [ "/home/${vars.username}/.ssh/id_ed25519" ];
    defaultSopsFile = ../secrets/system.yaml;
    secrets = {};
  };
}
