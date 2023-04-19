{ config, lib, pkgs, modulesPath, inputs, outputs, home-manager, user, ... }:
let
shared = import ../shared { inherit config lib pkgs inputs outputs home-manager user; };
in
{
  # Shared configuration across all machines

  imports = 
    # Default system installer configuration
    [( modulesPath + "/installer/scan/not-detected.nix" )] ++

    [shared] ++

    # Hardware configuration
    [( import ./hardware.nix )] ++

    # Partition table
    [( import ./partitions.nix )];
}
