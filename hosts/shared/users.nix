{ pkgs, user, name, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.${user} = {
    isNormalUser = true;
    description = "${name}";
    initialPassword = "nixos";
    extraGroups = 
      [ "wheel" "video" "audio" "input" ] 
      ++ ifTheyExist [ "network" "networkmanager" "camera" "git" "docker" "mysql" "kvm" "libvirtd" ];
    packages = [pkgs.home-manager];
    shell = pkgs.zsh;
  };

  home-manager.users."${user}" = import ../../home/desktop;
}
