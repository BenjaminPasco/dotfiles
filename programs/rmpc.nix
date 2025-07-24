{ pkgs, ... }:

{
  home.packages = [
  	pkgs.rmpc
  	pkgs.yt-dlp
  ];
  home.file.".config/rmpc/config.ron".source = ../config/rmpc/config.ron;
}
