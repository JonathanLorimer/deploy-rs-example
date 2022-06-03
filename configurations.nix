{
  nixpkgs,
  deploy-rs,
  self,
  ...
}: {
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

    node1-config = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({modulesPath, ...}: {
          imports = [(modulesPath + "/virtualisation/google-compute-image.nix")];
        })
        ({...}: {
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5PtmRVfHRGW9fvI0UE/QbeYWS2PGAZGQMGJqW6iI7va0B1FB/KNZnr2p7gttlmrQEMTLYwFbK/jGIq1OvarM3BcleL9MXYMjwjCZK5i0FqzcXYIsKjsYMzFLE1qsAnp7U2g+sUzhETmfprDkRnp4tX4dsD6yzWov3oNXAQGT4mPKihrD76Gr6y7VDy40q4F6/T9W0Tq80JCV3+LsFr8a1WNkmG+OibAm5Rnod7vlSqgWtb5AsZoH+L8TPJuzizGoQmCnoFL8Nx/9nNHH85tfWR4Lv++5MWUTWQ0TKHuz4R8oKpYqBSW1aWeQyvMvHMN0w6RnE+Q4MGTUFWFSczaRX62FC0jNWjYpsJLIO7g5nD8KKGsehHlDfTnILCeGwGJAvsJzB4mFsMx04UOkvfRFWSnVkOOxZMzM1VTIwIpldIlNr5io4ou2NJsChDkhjWVTIrItgA1CGrJkkg2qbtAhXut4zQWoFhnr20meUndj6O57NsfLrzeq1tM0nEeeGsulzQTnvTcLfofmwhPh0+MoYRcHUPrE8mqKAlFgzKF9UVT5QhbQved2Od4r3RcIlq8SzRBxiRp5/qu+aF1qHM5rYKJBEgCWCC0Rq6FGEjrDYq7giwwdAjW/AOCFGSifk7DyDcWNHo8imFMPBgrq8fXCzZnGgjW2vQvodAu36H0uCyQ== jonathan_lorimer@mac.com"
          ];
          users.users.jonathanl = {
            isNormalUser = true;
            openssh.authorizedKeys.keys = [
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPjfCP7P10yQFFpYS5GsIhrByWWdPgqfYvboWH0tqIRQFixbjWOv80IlD3TPXX6cbW2OtvelW4WRUtmIszzuexP36t8Kj6KESnoIGd1Lq15Yn2dRF4P2xLKBd1pEs84O6f6824XqeGVfokaCvt8pMHr9AEAHcgNAWDMNu5uJ3D5Yn4qhxNZAMXBps05ZbpEn9OjJVbEcwuV8p9PezyrcHcnyNtuc/LFfqQpUaddwjwHRFYBZ6HaMBFZJMBAXEeAUaEVn/utEZc1G9zsaZ/H5ZU3sYmcRyFFpLkdOlxilwH4Of9ZADpvf2I6JuQL9PfEpm7OIzohcs6oHm4upTLKm5DuefMbeuVAF9cqv+/B2MlVPhQu2CIkQimEe5M5Owqcl5MrsMrntuXdYGYGgObNiFOU72ydxDucJU32Vp8aMClyA376hfRIMhUl5qAiK7GOLNuW0ztzE1WM9RnQOTJGUDP4FJBB4tA3sehXcYXhLkUxjwx0EK7yogSkbcMu74XDsRb3gsX9Pnsca9g3uTyxR0Bb5hXM5i4RucvM1QE3yK/oFb2D85LmcIIxHgiBOpJxFZFc9r448JydK0PINbW+A769zX+B8TwPf9qlpzdTPnhzHnOLGYEkPXBeXgZF8AWnEon7MrRIJuOWO/F3eCpcyJ3TZ1u40xZpC13DSY0XMw20Q== jonathan_lorimer@mac.com"
            ];
          };
        })
      ];
    };
  };

  deploy.nodes = {
    node1 = {
      hostname = "35.211.149.122";
      sshUser = "root";
      user = "root";
      profiles.system = {
        user = "root";
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.node1-config;
      };
    };
  };

  checks = builtins.mapAttrs (_: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
}
