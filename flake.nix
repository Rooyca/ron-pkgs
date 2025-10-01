{
  description = "ron's meta-package flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    barli.url = "github:rooyca/barli-c";
    barli.inputs.nixpkgs.follows = "nixpkgs"; 
    barli-rust.url = "github:rooyca/barli";
    barli-rust.inputs.nixpkgs.follows = "nixpkgs"; 
    minipm.url = "github:rooyca/minipm";
    minipm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, barli, barli-rust, minipm, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          barli = barli.packages.${system};
          barli-rust = barli-rust.packages.${system}.default;
          minipm = minipm.packages.${system}.default;
        }
      );
    };
}

