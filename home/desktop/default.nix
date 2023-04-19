{ config, lib, pkgs, user, ... }:
{
  imports = [
    ../shared
    ./desktop.nix
  ];
}
