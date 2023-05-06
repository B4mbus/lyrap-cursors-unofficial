{
  description = "LyraP Cursors";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      formatter = pkgs.alejandra;

      packages.default = pkgs.stdenv.mkDerivation {
        name = "lyrap-cursors";
        pname = "lyrap-cursors";
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
