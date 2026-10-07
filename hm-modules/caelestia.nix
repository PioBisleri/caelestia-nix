{ inputs, pkgs, ... }: {

  xdg.configFile."caelestia/cli.json".text = ''
    {
      "theme": {
        "enableGtk": false
      }
    }
  '';

  programs.caelestia = {
    package = inputs."caelestia-shell".packages.${pkgs.stdenv.hostPlatform.system}.with-cli.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace components/filedialog/FolderContents.qml \
          --replace-fail 'Quickshell.iconPath("inode-directory")' \
                          'Quickshell.iconPath("folder")'
        substituteInPlace components/filedialog/FolderContents.qml \
          --replace-fail 'Quickshell.iconPath(`folder-''${file.name.toLowerCase()}`)' \
                          'Quickshell.iconPath(`folder-''${file.name.toLowerCase()}`, "folder")'
        printf '%s\n' '#%PAM-1.0' 'auth required pam_unix.so nullok' > assets/pam.d/passwd
      '';
    });

    enable = true;
    cli.enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/wallpaper";
      general = {
        apps.terminal = [ "kitty" ];
        idle.timeouts = [ ];
      };
      lock.enabled = true;
      bar.workspaces.shown = 9;
      background.wallpaperEnabled = true;
      services = {
        clockFormat = "TwelveHour";
        dataUnits = "Decimal";
        weatherLocation = "Chaibasa";
        weatherUnits = "Celsius";
      };
      launcher.favouriteApps = [
        "^brave-browser(\\.desktop)?$"
        "^kitty(\\.desktop)?$"
        "^nvim(\\.desktop)?$"
        "^thunar(\\.desktop)?$"
        "^net\\.lutris\\.Lutris(\\.desktop)?$"
        "^prismlauncher(\\.desktop)?$"
        "^org\\.kde\\.kdenlive(\\.desktop)?$"
      ];
    };
  };

}
