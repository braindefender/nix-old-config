{
  config,
  lib,
  pkgs,
  ...
}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs = {
    zsh.initExtraFirst = ''eval "$(${lib.getExe pkgs.starship} init zsh)"'';
    starship = {
      enable = true;
      settings = {
        format = "$all$fill$cmd_duration$line_break$shell$character";

        username = {
          show_always = true;
          format = "[$user]($style) [@](8) ";
          style_user = "red bold";
        };

        hostname = {
          disabled = false;
          ssh_only = false;
          format = "[$hostname]($style) [in](8) ";
          style = "yellow bold";
        };

        directory = {
          truncation_length = 3;
          truncate_to_repo = false;
          read_only = " ";
          style = "green bold";
        };

        git_branch = {
          symbol = " ";
          style = "cyan bold";
          format = "[on](8) [$symbol$branch(:$remote_branch)]($style) ";
        };

        fill = {
          symbol = " ";
        };

        time = {
          disabled = true;
          time_format = "%T";
          format = "[$time]($style)";
          style = "8";
        };

        character = {
          success_symbol = "[❱](bold blue)[❱](bold cyan)[❱](bold green)[❱](bold yellow)[❱](bold red)";
          error_symbol = "[](bold blue)[](bold cyan)[](bold green)[](bold yellow)[](bold red)";
        };

        # icons

        aws = {
          symbol = "  ";
        };

        buf = {
          symbol = " ";
        };

        c = {
          symbol = " ";
        };

        conda = {
          symbol = " ";
        };

        dart = {
          symbol = " ";
        };

        docker_context = {
          symbol = " ";
        };

        elixir = {
          symbol = " ";
        };

        elm = {
          symbol = " ";
        };

        golang = {
          symbol = " ";
        };

        haskell = {
          symbol = " ";
        };

        hg_branch = {
          symbol = " ";
        };

        java = {
          symbol = " ";
        };

        julia = {
          symbol = " ";
        };

        lua = {
          symbol = " ";
        };

        memory_usage = {
          symbol = " ";
        };

        meson = {
          symbol = "喝 ";
        };

        nim = {
          symbol = " ";
        };

        nix_shell = {
          symbol = " ";
        };

        nodejs = {
          symbol = " ";
          format = "[via](8) [$symbol($version)]($style)";
        };

        package = {
          symbol = " ";
        };

        python = {
          symbol = " ";
        };

        ruby = {
          symbol = " ";
        };

        rust = {
          symbol = " ";
        };

        scala = {
          symbol = " ";
        };

        spack = {
          symbol = "🅢 ";
        };
      };
    };
  };
}
