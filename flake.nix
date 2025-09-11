{
  description = "ron's meta-package flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    barli.url = "github:rooyca/barli";
    minipm.url = "github:rooyca/minipm";
  };

  outputs = { self, nixpkgs, barli, minipm }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      packages.x86_64-linux = {
        barli = barli.packages.${pkgs.system}.default;
        minipm = minipm.packages.${pkgs.system}.default;
      };
    };
}
