{
  description = "protopedal";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = protopedal;
          protopedal = pkgs.stdenv.mkDerivation {
            pname = "protopedal";
            version = "master";

            src = pkgs.fetchFromGitLab {
              owner = "openirseny";
              repo = "protopedal";
              rev = "master";
              hash = "sha256-eOCx4jeeFtcwGP1hq72HGHvPJKmMNJR3+OTi/U7pd/I=";
            };

            installPhase = ''
              runHook preInstall
              mkdir -p $out/bin
              cp protopedal $out/bin
              runHook postInstall
            '';
          };
        };
      }
    );
}
