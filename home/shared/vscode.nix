{pkgs, ...}: let
  prettier = {"editor.defaultFormatter" = "esbenp.prettier-vscode";};
in {
  xdg.configFile."code-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim # Vim
      jnoortheen.nix-ide # Nix IDE
      catppuccin.catppuccin-vsc # Catppuccin Theme
      eamodio.gitlens # GitLens
      dbaeumer.vscode-eslint # ESLint
      esbenp.prettier-vscode # Prettier
    ];

    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "emmet.useInlineCompletions" = true;
      "security.workspace.trust.enabled" = false;
      "extensions.ignoreRecommendations" = true;
      "workbench.colorTheme" = "Catppuccin Macchiato";

      "window.zoomLevel" = 1;
      "window.titleBarStyle" = "custom";

      "workbench.settings.useSplitJSON" = true;
      "workbench.layoutControl.type" = "toggles";
      "workbench.sideBar.location" = "right";
      "workbench.list.smoothScrolling" = true;
      "workbench.tree.renderIndentGuides" = "always";
      "workbench.tree.indent" = 12;

      "explorer.confirmDelete" = false;
      "explorer.fileNesting.expand" = false;
      "explorer.fileNesting.patterns" = {
        "*.tsx" = "\$\{capture\}.ts, \$\{capture\}.styles.ts, \$\{capture\}.stories.tsx, \$\{capture\}.spec.tsx, index.ts";
        "jest.config.js" = "jest.config.js, jest.setup.js";
        "*.yml" = "gitlab-ci*.yml";
      };

      "files.autoSave" = "onFocusChange";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;

      # Cursor
      "editor.cursorWidth" = 2;
      "editor.cursorBlinking" = "solid";
      "editor.cursorSurroundingLines" = 4;

      # Font
      "editor.fontSize" = 13;
      "editor.lineHeight" = 1.45;
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "400";
      "editor.fontFamily" = "CaskaydiaCove Nerd Font Mono";

      # Behaviour
      "editor.suggest.preview" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "editor.linkedEditing" = true;
      "editor.lineNumbers" = "relative";
      "editor.renderLineHighlight" = "all";
      "editor.gotoLocation.multipleDefinitions" = "goto";

      # Scroll
      "editor.smoothScrolling" = true;
      "editor.stickyScroll.enabled" = true;
      "editor.scrollBeyondLastLine" = false;
      "editor.scrollbar.verticalScrollbarSize" = 8;
      "editor.scrollbar.horizontalScrollbarSize" = 8;

      # Others
      "editor.minimap.showSlider" = "always";
      "editor.minimap.renderCharacters" = false;
      "editor.accessibilitySupport" = "off";
      "editor.unicodeHighlight.allowedLocales" = {
        ru = true;
      };

      # Terminal
      "terminal.integrated.cursorStyle" = "underline";
      "terminal.integrated.fontSize" = 13;
      "terminal.integrated.fontWeight" = "400";
      "terminal.integrated.fontFamily" = "CaskaydiaCove Nerd Font Mono";
      "terminal.integrated.scrollback" = 10000;
      "terminal.integrated.smoothScrolling" = true;

      # VIM Settings
      "vim.leader" = " ";
      "vim.history" = 1000;
      "vim.inccommand" = "append"; # show inline substitutions
      "vim.useSystemClipboard" = true;

      # VIM Keybindings
      "vim.handleKeys" = {
        "<C-d>" = true;
        "<C-f>" = false;
        "<C-s>" = false;
        "<C-z>" = false;
      };

      "vim.insertModeKeyBindingsNonRecursive" = [
        {
          before = ["j" "k"];
          after = ["<Esc>" "l"];
        }
      ];

      # VIM Plugins
      "vim.camelCaseMotion.enable" = true;
      "vim.highlightedyank.enable" = true;

      "typescript.updateImportsOnFileMove.enabled" = "always";

      # Turn off stupid auto-formatter that breaks files
      "[less]" = {
        "editor.formatOnSave" = false;
      };

      # Prettier Everything
      "[html]" = prettier;
      "[css]" = prettier;
      "[json]" = prettier;
      "[jsonc]" = prettier;
      "[astro]" = prettier;
      "[markdown]" = prettier;
      "[javascript]" = prettier;
      "[javascriptreact]" = prettier;
      "[typescript]" = prettier;
      "[typescriptreact]" = prettier;
    };
  };
}
