{
  nixpkgs,
  flake-utils,
  pre-commit-hooks,
  deploy-rs,
  self,
  ...
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
        gce-image = self.nixosConfigurations.gce-image-config.config.system.build.googleComputeImage;
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
          deploy-rs.packages.${system}.deploy-rs
        ];
      };
    }
  )
