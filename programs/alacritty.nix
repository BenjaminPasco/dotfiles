{ ... }:

{
  # TODO move this to nixpakages import and dedicated config file but can't be bothered right now
  programs.alacritty = {
  	enable = true;
  	settings.font.normal.family = "FiraMono Nerd Font Mono";
  	settings.font.size = 16;
  };
}
