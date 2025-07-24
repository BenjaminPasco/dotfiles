{
	description = "initial nix config";
	inputs = {
		# Where we get all the software from. Giant monorepo with recipes called derivations
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

		# Manages configs links things into home directory
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		# Controls system level software and settings for Macos
		darwin.url = "github:lnl7/nix-darwin";
		darwin.inputs.nixpkgs.follows = "nixpkgs";
	};
	outputs = inputs: {
		darwinConfigurations.default = inputs.darwin.lib.darwinSystem {
			system = "aarch64-darwin";
			pkgs = import inputs.nixpkgs {
				system = "aarch64-darwin";
				config.allowUnfree = true;
			};
			modules = [
			 (import ./systems/darwin/default.nix { inherit inputs; })
			];
		};
	};
}
