{ ... }:

let
  userConfig = import ../flakes/user.nix;
  inherit (userConfig) userGithubEmail userGithubName;
in
{
  # TODO move this to nixpakages import and dedicated config file but can't be bothered right now
  programs.git = {
  	enable = true;
  	userName = userGithubName;
  	userEmail = userGithubEmail;
  };
}
