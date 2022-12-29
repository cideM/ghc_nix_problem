{
  description = "Nix Flake template using the 'nixpkgs-unstable' branch and 'flake-utils'";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        workaround140774 = haskellPackage:
          with pkgs.haskell.lib;
            overrideCabal haskellPackage (drv: {
              enableSeparateBinOutput = false;
            });

        ghc = pkgs.haskell.packages.ghc810;

        app = ghc.callPackage ./project.nix {};
      in rec {
        packages = flake-utils.lib.flattenTree {
          inherit app;
        };

        defaultPackage = packages.app;
        apps.app = flake-utils.lib.mkApp {drv = packages.app;};
        defaultApp = apps.app;

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            coreutils
            moreutils
            jq
            cabal2nix
            (workaround140774 haskellPackages.ormolu)
            (ghc.ghcWithPackages (pkgs: [
              pkgs.cabal-install
              pkgs.cabal-fmt
            ]))
          ];
        };
      }
    );
}
