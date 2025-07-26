{pkgs, ...}:

let
  userConfig = import ../flakes/user.nix;
  inherit (userConfig) username;
in
{
  home.stateVersion = "25.05";
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.sessionVariables = {
  	PAGER = "less";
  	CLICOLOR = 1;
  	EDITOR = "vim";
  };

  imports = [
    ../programs/aerospace.nix
    ../programs/alacritty.nix
    ../programs/bat.nix
    ../programs/fzf.nix
    ../programs/ghostty.nix
    ../programs/git.nix
    ../programs/helix.nix
    ../programs/mpd.nix
    ../programs/rmpc.nix
    ../programs/starship.nix
    ../programs/yazi.nix
    ../programs/zellij.nix
    ../programs/zsh.nix
  ];
  
  home.packages = [
  	pkgs.fd
  	pkgs.curl
  	pkgs.less
  	pkgs.ripgrep
  	pkgs.raycast
  	pkgs.fontconfig
    pkgs.whatsapp-for-mac
  ];

  home.file.".inputrc".source = ../config/.inputrc;
}
