{
  description = "Deploy-rs example";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    pre-commit-hooks.url = github:cachix/pre-commit-hooks.nix;
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
    deploy-rs.url = github:serokell/deploy-rs;
  };

  outputs = inputs:
    inputs.nixpkgs.lib.recursiveUpdate
    (import ./outputs.nix inputs)
    (import ./configurations.nix inputs);
}
