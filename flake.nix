{
  description = "LyraP Cursors";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      name = "lyrap-cursors";
    in {
      formatter = pkgs.alejandra;

      packages.default = pkgs.stdenv.mkDerivation {
        inherit name;

        src = self;

        installPhase = let
          installPath = "$out/share/icons/LyraP-Cursors";
        in ''
          mkdir -p ${installPath}
          cp -va index.theme cursors/ ${installPath}
        '';
      };
    });
}
