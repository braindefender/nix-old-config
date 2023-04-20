{ pkgs, ... }:

{
  programs = {
    adb.enable = true;
    zsh.enable = true;
    dconf.enable = true;
    ssh.startAgent = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        glib
        glibc
        icu
        libunwind
        libuuid
        libsecret
        openssl
        stdenv.cc.cc
        util-linux
        zlib
      ];
    };

    # java = {
    #   enable = true;
    #   package = pkgs.jre;
    # };
  };
}
