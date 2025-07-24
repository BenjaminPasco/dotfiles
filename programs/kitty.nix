{ ... }:

{
  home.packages = [
  	pkgs.kitty
  ];
  home.file.".config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;
  home.file.".config/kitty/rose-pine.conf".source = ../config/kitty/rose-pine.conf;
}
