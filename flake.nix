



{
  description = "ron's meta-package flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    barli.url = "github:rooyca/barli-c";
    barli.inputs.nixpkgs.follows = "nixpkgs"; 
    minipm.url = "github:rooyca/minipm";
    minipm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, barli, minipm, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          barli = barli.packages.${system};
          minipm = minipm.packages.${system}.default;
        }
      );
    };
}

