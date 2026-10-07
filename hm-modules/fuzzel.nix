{ ... }: {

  xdg.configFile."fuzzel/fuzzel.ini" = {
    force = true;
    text = ''
    include=/home/veer/.config/matugen/fuzzel-colors.ini

    [main]
    font=JetBrainsMono Nerd Font:size=13
    dpi-aware=yes
    prompt=>
    width=48
    line-height=24
  '';
  };

}
