# deploy-rs example

## Bootstrapping Steps

1. Run `nix build .#gce-image`
2. You should be able to publish the base image to gce via terraform now
3. As long as you have the [root ssh key](https://github.com/JonathanLorimer/deploy-rs-example/blob/main/configurations.nix#L15-L17) for the base image, you should be able to run `deploy .#node1` (or whatever name you have chosen for your [node](https://github.com/JonathanLorimer/deploy-rs-example/blob/main/configurations.nix#L44)) 
