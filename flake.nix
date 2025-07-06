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
			({ pkgs, ...}: {
				users.users.benjaminpasco = {
					name = "benjaminpasco";
					home = "/Users/benjaminpasco";
					shell = pkgs.zsh;
				};
				system.primaryUser = "benjaminpasco";
				system.stateVersion = 6;
				# here go the darwin preferences and configuration
				programs.zsh.enable = true;
				environment.shells = [ pkgs.bash pkgs.zsh ];
				nix.extraOptions = ''
					experimental-features = nix-command flakes
				'';
				environment.systemPackages = [ pkgs.coreutils ];
				system.keyboard.enableKeyMapping = true;
				system.keyboard.remapCapsLockToEscape = true;
				# Maybe disable this at first
				fonts.packages = [ pkgs.nerd-fonts.fira-mono ];
				system.defaults.finder.AppleShowAllExtensions = true;
				system.defaults.finder._FXShowPosixPathInTitle = true;
				system.defaults.dock.autohide = true;
				system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
				system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
				system.defaults.NSGlobalDomain.KeyRepeat = 1;
				homebrew = {
					enable = true;
					caskArgs.no_quarantine = true;
					global.brewfile = true;
					masApps = {};
					casks = [ "ghostty" ];
				};
			})
			inputs.home-manager.darwinModules.home-manager {
				home-manager = {
					useGlobalPkgs = true;
					# useUserPkgs = true;
					users.benjaminpasco.imports = [
						({pkgs, ...}: {
							# Specify home-manager configs
							home.stateVersion = "25.05";
							home.username = "benjaminpasco";
							home.homeDirectory = "/Users/benjaminpasco";
							home.packages = [
								pkgs.fd
								pkgs.curl
								pkgs.less
								pkgs.ripgrep
								pkgs.kitty
								pkgs.helix
								pkgs.raycast
								pkgs.aerospace
							];
							home.sessionVariables = {
								# dont know what that is
								PAGER = "less";
								CLICOLOR = 1;
								EDITOR = "vim";
							};
							programs.bat.enable = true;
							programs.bat.config.theme = "TwoDark";
							programs.fzf.enable = true;
							programs.fzf.enableZshIntegration = true;
							programs.zsh.enable = true;
							programs.zsh.enableCompletion = true;
							programs.zsh.autosuggestion.enable = true;
							programs.zsh.syntaxHighlighting.enable = true;
							programs.zsh.shellAliases = { ls = "ls --color=auto -F"; };
							programs.starship.enable = true;
							programs.starship.enableZshIntegration = true;
							programs.alacritty = {
								enable = true;
								settings.font.normal.family = "FiraMono Nerd Font Mono";
								settings.font.size = 16;
							};
							programs.git = {
								enable = true;
								userName = "Benjamin Pasco";
								userEmail = "benjamin.pasco@hotmail.fr";
							};
							home.file.".inputrc".text = ''
								set show-all-if-ambiguous on
								set completion-ignore-case on
								set mark-directories on
								set mark-symlinked-directories on
								set match-hidden-files off
								set visible-stats on
							'';
							home.file.".aerospace.toml".source = ./config/aerospace.toml;
						})
					];
				};
			} ]; };
	};
}
