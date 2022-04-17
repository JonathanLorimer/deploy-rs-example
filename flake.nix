{
  description = "Validator configurations for Nix Equipment";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    pre-commit-hooks.url = github:cachix/pre-commit-hooks.nix;
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
    deploy-rs.url = github:serokell/deploy-rs;
    cosmos-nix.url = github:informalsystems/cosmos.nix;
  };

  outputs = inputs:
    inputs.nixpkgs.lib.recursiveUpdate
    (import ./outputs.nix inputs)
    (import ./configurations.nix inputs);
}
