{
  description = "System configuration with Ghostty";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = { self, nixpkgs, ghostty }:
    let
      system = "aarch64-darwin"; # For Apple Silicon Macs
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Development shell (for nix develop)
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          ghostty.packages.${system}.default
        ];
        
        shellHook = ''
          echo "Ghostty is available in this shell!"
          echo "Run 'ghostty --help' to see options"
        '';
      };

      # For nix-darwin
      darwinConfigurations.yourhostname = nixpkgs.lib.darwinSystem {
        system = system;
        modules = [
          {
            environment.systemPackages = [
              ghostty.packages.${system}.default
            ];
          }
        ];
      };

      # Just the package for easy access
      packages.${system} = {
        default = ghostty.packages.${system}.default;
        ghostty = ghostty.packages.${system}.default;
      };
    };
}
