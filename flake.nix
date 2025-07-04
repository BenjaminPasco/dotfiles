{
  description = "My development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Import our custom packages
        ghostty-custom = pkgs.callPackage ./packages/ghostty.nix {};
        
      in {
        # Development shell with all our tools
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            ghostty-custom
            # Add more tools here as you build them
          ];
          
          # Setup script that runs when entering the shell
          shellHook = ''
            echo "🚀 Development environment loaded!"
            echo "Ghostty available at: $(which ghostty)"
            
            # Create config directories if they don't exist
            mkdir -p ~/.config/ghostty
            
            # Link your config files
            ln -sf ${./configs/ghostty/config} ~/.config/ghostty/config
            
            echo "✅ Ghostty configured"
          '';
        };
        
        # Make packages available for direct installation
        packages.ghostty = ghostty-custom;
        packages.default = ghostty-custom;
      }
    );
}
