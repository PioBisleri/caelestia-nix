{ config, pkgs, ... }: {

  programs.fetch = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      upgrade = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild boot --flake /etc/nixos#nixos";
      flake-update = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      test = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
      boot = "sudo nixos-rebuild boot --flake /etc/nixos#nixos";
      rollback = "sudo nixos-rebuild switch --rollback --flake /etc/nixos#nixos";
      repair = "sudo nixos-rebuild switch --repair --flake /etc/nixos#nixos";
      history = "sudo nix profile history --profile /nix/var/nix/profiles/system";
      generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      garbage = "sudo nix-collect-garbage -d";
      clean = "sudo nix-collect-garbage -d && nix store optimise";
      search = "nix search nixpkgs";
      ls = "ls --color=auto";
      ll = "ls -lah";
      la = "ls -la";
      l = "ls -l";
      ".." = "cd ..";
      "..." = "cd ../..";
      "-" = "cd -";
      "~" = "cd ~";
      grep = "grep --color=auto";
      ":q" = "exit";
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      df = "df -h";
      du = "du -h";
      free = "free -h";
      ps = "ps auxf";
      ports = "ss -tulanp";
      top = "btop";
      vim = "nvim";
      vi = "nvim";
      edit = "nvim";
      dot = "nvim /etc/nixos";
      cat = "bat";
      y = "yazi";
      g = "git";
      gi = "git init";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpl = "git pull";
      gm = "git merge";
      gf = "git fetch";
      gst = "git stash";
      grs = "git restore";
      gcb = "git checkout -b";
      gpsup = "git push --set-upstream origin HEAD";
      gl = "git log --oneline";
      glog = "git log --oneline --graph --decorate";
      gd = "git diff";
      gco = "git checkout";
      gb = "git branch";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      save = 10000;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    initContent = ''
      mkcd() { mkdir -p "$1" && cd "$1"; }
      fetch
      eval "$(starship init zsh)"
    '';
  };

}
