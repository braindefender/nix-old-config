{
  config,
  lib,
  pkgs,
  ...
}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs = {
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
      };
    };
  };
}
