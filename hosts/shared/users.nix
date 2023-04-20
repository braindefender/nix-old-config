{
  config,
  pkgs,
  user,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.${user} = {
    isNormalUser = true;
    password = "nixos";
    extraGroups =
      ["wheel" "video" "audio" "input" "networkmanager"]
      ++ ifTheyExist ["camera" "git" "docker" "mysql" "kvm" "libvirtd"];
    packages = [pkgs.home-manager];
    shell = pkgs.zsh;
  };
}
