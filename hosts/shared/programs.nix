{ pkgs, ... }:

{
  programs = {
    adb.enable = true;
    zsh.enable = true;
    dconf.enable = true;
    qt5ct.enable = true;
    ssh.startAgent = true;

    waybar.enable = true;
    sway = {
      enable = true;

      wrapperFeatures.gtk = true;
      extraOptions = [ "--unsupported-gpu" ];
      extraPackages = with pkgs; [
        swaylock
	swayidle
	wl-clipboard
	wf-recorder
	wofi
	mako
	grim
	slurp
      ];
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
      '';
    };

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
