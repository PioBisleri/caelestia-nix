{ vars, ... }: {

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=/home/${vars.username}/.config/matugen/qt6ct-colors.conf
    custom_palette=true
    icon_theme=Papirus-Dark
  '';

}
