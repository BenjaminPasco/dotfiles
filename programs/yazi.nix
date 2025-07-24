{ pkgs, ... }:

{
  home.packages = [
  	pkgs.yazi
  ];
  home.file.".config/yazi/yazi.toml".source = ../config/yazi/yazi.toml;
  home.file.".config/yazi/theme.toml".source = ../config/yazi/theme.toml;
}
