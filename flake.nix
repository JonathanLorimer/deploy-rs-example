{
  description = "A reproducible package set for Cosmos";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    pre-commit-hooks.url = github:cachix/pre-commit-hooks.nix;
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    pre-commit-hooks,
    self,
  }:
    with flake-utils.lib;
      eachDefaultSystem (
        system: let
          pkgs = import nixpkgs {inherit system;};
        in {
          checks = {
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                alejandra.enable = true;
                nix-linter.enable = true;
                terraform-format.enable = true;
              };
            };
          };

          packages = {
            gce-image = self.nixosConfigurations.${system}.gce-image-config.config.system.build.googleComputeImage;
          };

          devShells.default = pkgs.mkShell {
            shellHook = ''
              ${self.checks.${system}.pre-commit-check.shellHook}
            '';
            buildInputs = with pkgs; [
              terraform
              alejandra
              nix-linter
              google-cloud-sdk
            ];
          };
        }
      )
      // {
        nixosConfigurations = {
          gce-image-config = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ({modulesPath, ...}: {
                imports = [(modulesPath + "/virtualisation/google-compute-image.nix")];
              })
              ({...}: {
                users.users.root.openssh.authorizedKeys.keys = [
                  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5PtmRVfHRGW9fvI0UE/QbeYWS2PGAZGQMGJqW6iI7va0B1FB/KNZnr2p7gttlmrQEMTLYwFbK/jGIq1OvarM3BcleL9MXYMjwjCZK5i0FqzcXYIsKjsYMzFLE1qsAnp7U2g+sUzhETmfprDkRnp4tX4dsD6yzWov3oNXAQGT4mPKihrD76Gr6y7VDy40q4F6/T9W0Tq80JCV3+LsFr8a1WNkmG+OibAm5Rnod7vlSqgWtb5AsZoH+L8TPJuzizGoQmCnoFL8Nx/9nNHH85tfWR4Lv++5MWUTWQ0TKHuz4R8oKpYqBSW1aWeQyvMvHMN0w6RnE+Q4MGTUFWFSczaRX62FC0jNWjYpsJLIO7g5nD8KKGsehHlDfTnILCeGwGJAvsJzB4mFsMx04UOkvfRFWSnVkOOxZMzM1VTIwIpldIlNr5io4ou2NJsChDkhjWVTIrItgA1CGrJkkg2qbtAhXut4zQWoFhnr20meUndj6O57NsfLrzeq1tM0nEeeGsulzQTnvTcLfofmwhPh0+MoYRcHUPrE8mqKAlFgzKF9UVT5QhbQved2Od4r3RcIlq8SzRBxiRp5/qu+aF1qHM5rYKJBEgCWCC0Rq6FGEjrDYq7giwwdAjW/AOCFGSifk7DyDcWNHo8imFMPBgrq8fXCzZnGgjW2vQvodAu36H0uCyQ== jonathan_lorimer@mac.com"
                ];
              })
            ];
          };
        };
      };
}
