{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  nushell_config = builtins.readFile ./nushell.nu;
  nushell_git_completions = builtins.readFile ./git-completions.nu;

  nushell_combined = builtins.concatStringsSep "\n" [
    nushell_config
    nushell_git_completions
  ];
in {
  programs = {
    nushell = {
      enable = true;

      configFile.text = nushell_combined;

      extraEnv = ''
        let-env FZF_DEFAULT_OPTS = "
          --color fg:#6c7086
          --color fg+:#1e1e2e
          --color bg:#313244
          --color bg+:#cba6f7
          --color hl:#f5e0dc
          --color hl+:#313244
          --color info:#585b70
          --color marker:#1e1e2e
          --color prompt:#a6e3a1
          --color spinner:#f38ba8
          --color pointer:#1e1e2e
          --color header:#cba6f7
          --color preview-fg:#f5e0dc
          --color preview-bg:#1e1e2e
          --color gutter:#313244
          --color border:#11111b
          --border
          --prompt 'λ '
          --pointer ''
          --marker ''
        "
      '';

      extraConfig = "let st = (${pkgs.starship}/bin/starship init nu); $st";

      shellAliases = with pkgs; {
        # Base
        q = "exit";
        c = "clear";
        m = "mkdir";
        v = "${lib.getExe neovim}";
        cat = "${lib.getExe bat} -p";
        dust = "${lib.getExe du-dust}";
        hx = "helix";

        # Exa instead of ls
        l = "${lib.getExe exa} -l --group-directories-first --time-style long-iso --no-user --icons";
        ll = "${lib.getExe exa} -la --group-directories-first --time-style long-iso --no-user --icons";
        la = "${lib.getExe exa} -la --group-directories-first --time-style long-iso --no-user --icons";
        tree = "${lib.getExe exa} --tree --icons --level=2";
        treee = "${lib.getExe exa} --tree --icons --level=3";

        # Git
        g = "git";
        push = "git push";
        pull = "git pull";
        fetch = "git fetch";
        commit = "git add . and git commit -m";

        # YouTube (download video and/or audio)
        ytv = "${lib.getExe yt-dlp} --format \"bv*+ba/b\"";
        yta = ''
          ${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
        '';

        # NixOS
        cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
        bloat = "nix path-info -Sh /run/current-system";

        # Others
      };
    };
  };

}
