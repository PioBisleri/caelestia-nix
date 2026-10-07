{ config, pkgs, ... }: {

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-theme-name = "catppuccin-mocha-mauve-standard";
    };
  };

  xdg.dataFile."themes/catppuccin-mocha-mauve-standard" = {
    source = "${pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; }}/share/themes/catppuccin-mocha-mauve-standard";
    recursive = true;
  };


  xdg.configFile."gtk-3.0/gtk.css".source = ../gtk-css/gtk-3.0/gtk.css;
  xdg.configFile."gtk-3.0/thunar.css".source = ../gtk-css/gtk-3.0/thunar.css;
  xdg.configFile."gtk-4.0/gtk.css".source = ../gtk-css/gtk-4.0/gtk.css;
  xdg.configFile."gtk-4.0/thunar.css".source = ../gtk-css/gtk-4.0/thunar.css;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "catppuccin-mocha-mauve-standard";
      icon-theme = "Papirus-Dark";
      color-scheme = "prefer-dark";
    };
  };

}