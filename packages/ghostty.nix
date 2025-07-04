{ lib
, stdenv
, fetchFromGitHub
, zig
, pkg-config
, fontconfig
, freetype
, libGL
, libX11
, libXcursor
, libXi
, libXinerama
, libXrandr
, libglvnd
, libxkbcommon
, wayland
, darwin
}:

stdenv.mkDerivation rec {
  pname = "ghostty";
  version = "1.0.0"; # Update this to match latest

  src = fetchFromGitHub {
    owner = "ghostty-org";
    repo = "ghostty";
    rev = "v${version}"; # or specific commit
    sha256 = ""; # You'll need to update this hash
  };

  nativeBuildInputs = [
    zig
    pkg-config
  ];

  buildInputs = if stdenv.isDarwin then [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.CoreText
    darwin.apple_sdk.frameworks.Foundation
    darwin.apple_sdk.frameworks.Metal
    darwin.apple_sdk.frameworks.QuartzCore
  ] else [
    fontconfig
    freetype
    libGL
    libX11
    libXcursor
    libXi
    libXinerama
    libXrandr
    libglvnd
    libxkbcommon
    wayland
  ];

  # Zig build flags
  zigBuildFlags = [
    "-Doptimize=ReleaseFast"
    "-Dtarget=${stdenv.hostPlatform.config}"
  ];

  buildPhase = ''
    runHook preBuild
    
    # Set up zig cache
    export ZIG_GLOBAL_CACHE_DIR="$TMPDIR/zig-cache"
    export ZIG_LOCAL_CACHE_DIR="$TMPDIR/zig-cache"
    
    # Build with zig
    zig build ${toString zigBuildFlags}
    
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp zig-out/bin/ghostty $out/bin/
    
    # Install resources if they exist
    if [ -d "zig-out/share" ]; then
      cp -r zig-out/share $out/
    fi
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "A cross-platform, GPU-accelerated terminal emulator";
    homepage = "https://ghostty.org";
    license = licenses.mit;
    platforms = platforms.unix ++ platforms.darwin;
  };
}
