{ pkgs, lib, config, ... }:

let
  berkeleyMonoDir = "${config.home.homeDirectory}/Projects/dotfiles/assets/fonts/berkeley-mono";
  patchedDir = "${berkeleyMonoDir}/patched";
  
  # Check if patched fonts exist
  patchedFontsExist = builtins.pathExists patchedDir;
  
  # Simple font package for already-patched fonts
  berkeleyMonoNerdFont = pkgs.stdenv.mkDerivation {
    name = "berkeley-mono-nerd-font";
    src = patchedDir;
    
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      find . -name "*.ttf" -exec cp {} $out/share/fonts/truetype/ \;
      find . -name "*.otf" -exec cp {} $out/share/fonts/truetype/ \;
    '';
    
    meta = {
      description = "Berkeley Mono Nerd Font (pre-patched)";
    };
  };

in {
  home.activation.berkeleyMonoSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -n "$(ls -A "${patchedDir}"/BerkeleyMonoNerdFont*.ttf 2>/dev/null)" ]; then
      echo "✅ Berkeley Mono Nerd fonts found in dotfiles"
      
      # Install to macOS user fonts directory (where macOS looks for fonts)
      mkdir -p "${config.home.homeDirectory}/Library/Fonts"
      cp "${patchedDir}"/BerkeleyMonoNerdFont*.ttf "${config.home.homeDirectory}/Library/Fonts/"
      
      echo "✅ Berkeley Mono fonts installed to ~/Library/Fonts"
    else
      echo "❌ Berkeley Mono Nerd fonts not found in ${patchedDir}"
    fi
  '';

  fonts.fontconfig.enable = true;
  home.packages = [ pkgs.fontconfig ];
}
