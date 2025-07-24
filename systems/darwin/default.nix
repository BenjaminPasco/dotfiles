{inputs }:

{pkgs, ...}:

let
  userConfig = import ../../flakes/user.nix;
  inherit (userConfig) username;
in
{
  # User configation
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  system.primaryUser = username;
  system.stateVersion = 6;

  # Shell configuration
  programs.zsh.enable = true;
  environment.shells = [ pkgs.bash pkgs.zsh ];

  # Nix configuration
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # System packages
  environment.systemPackages = [ pkgs.coreutils ];

  # Keyboard settings
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true; # This is usefull for vim/helix

  # Fonts
  fonts.packages = [ pkgs.nerd-fonts.fira-mono ];

  # System defaults
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
    dock = {
      autohide = true;
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
    };
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = [ "ghostty" ];
  };  

  imports = [
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        users.${username}.imports = [
          ../../home/default.nix
          ../../flakes/berkeley-mono.nix
        ];
      }; 
    }
  ];
}
