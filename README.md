need to install homebrew:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

first command to build the nix.flake file with "default" profile:
nix --extra-experimental-features "nix-command flakes" build .#darwinConfigurations.default.system
this command should build and create a .result directory symlinked to the /nix/store directory

then run this:
sudo ./result/sw/bin/darwin-rebuild switch --flake ~/Projects/nix#default
which should activate our built "default" configuration

when done already once, can then use this command to rebuild the config
sudo darwin-rebuild switch --flake ~/Projects/nix#default

