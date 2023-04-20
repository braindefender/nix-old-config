{
  lib,
  pkgs,
  ...
}: {
  environment = with pkgs; {
    variables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    binsh = lib.getExe bash;
    pathsToLink = ["/share/zsh"];

    # #  dbus-update-activation-environment --all
    # loginShellInit = ''
    #   eval $(gnome-keyring-daemon --start --daemonize --components=pkcs11,secrets,ssh)
    #   eval $(ssh-agent)
    # '';
  };
}
