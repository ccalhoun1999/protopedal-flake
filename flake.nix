{
  description = "protopedal"

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, fetchFromGitLab, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = protopedal;
          protopedal = pkgs.stdenv.mkDerivation {
            pname = "protopedal";
            version = "master";

            src = fetchFromGitLab {
              owner = "openirseny";
              repo = "protopedal";
              rev = "${version}";
              hash = "sha256-z4Wt2/64/b6CMs/qFS8Q3n0u/3NbFGWUZIFODCsBTcI=";
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
