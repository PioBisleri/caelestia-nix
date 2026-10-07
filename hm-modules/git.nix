{ config, pkgs, vars, ... }: {

  programs.git = {
    enable = true;
    settings = {
      user.name = vars.fullName;
      user.email = vars.email;
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

}