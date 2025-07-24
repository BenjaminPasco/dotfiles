{ pkgs, ... }:

let
  userConfig = import ../flakes/user.nix;
  inherit (userConfig) username;
in
{
  home.packages = [
  	pkgs.mpd
  ];
  home.file.".config/mpd/mpd.conf".source = ../config/mpd/mpd.conf;
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    dataDir = "/Users/${username}/.local/share/mpd";
  };
}
