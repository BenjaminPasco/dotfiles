{ pkgs, ... }:

{
  home.packages = [
  	pkgs.aerospace
  ];
  home.file.".aerospace.toml".source = ../config/aerospace.toml;
}
