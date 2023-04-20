{}:
let 
  prettier = { editor.defaultFormatter = "esbenp.prettier-vscode"; };
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;

    userSettings = {
      telemetry.telemetryLevel = "off";
      emmet.useInlineCompetions = true;
      security.workspace.trust.enabled = false;
      extensions.ignoreRecommendations = true;

      window = {
        zoomLevel = 1;
      };

      workbench = {
        settings.useSplitJSON = true;
        layoutControl.type = "toggles";
        sideBar.location = "right";
        list.smoothScrolling = true;
        tree.renderIndentGuides = "always";
        tree.indent = 12;
      };

      explorer = {
        confirmDelete = false;
        fileNesting.expand = false;
        fileNesting.patterns = {
          "*.tsx" = "\$\{capture\}.ts, \$\{capture\}.styles.ts, \$\{capture\}.stories.tsx, \$\{capture\}.spec.tsx, index.ts";
          "jest.config.js" = "jest.config.js, jest.setup.js";
          "*.yml" = "gitlab-ci*.yml";
        };
      };

      files = {
        autoSave = "onFocusChange";
        insertFinalNewline = true;
        trimFinalNewlines = true;
        trimTrailingWhitespace = true;
      };

      editor = {
        # Cursor
        cursorWidth = 2;
        cursorBlinking = "solid";
        cursorSurroundingLines = 4;

        # Font
        fontSize = 13;
        lineHeight = 1.45;
        fontLigatures = true;
        fontWeight = 350;

        # Behaviour
        suggest.preview = true;
        formatOnSave = true;
        formatOnPaste = true;
        linkedEditing = true;
        lineNumbers = "relative";
        renderLineHighlight = "all";
        gotoLocation.multipleDefinitions = "goto";

        # Scroll
        smoothScrolling = true;
        stickyScroll.enabled = true;
        scrollBeyondLastLine = false;
        scrollbar = {
          verticalScrollbarSize = 8;
          horizontalScrollbarSize = 8;
        };

        # Others
        minimap.showSlider = "always";
        minimap.renderCharacters = false;
        accessibilitySupport = "off";
        unicodeHighlight.allowedLocales.ru = true;
      };

      terminal.integrated = {
        cursorStyle = "underline";  
        fontSize = 13;  
        fontWeight = "350";  
        scrollback = 10000;  
        smoothScrolling = true;
      };

      vim = {
        leader = " ";
        history = 1000;
        inccommand = "append"; # show inline substitutions
        useSystemClipboard = true;

        handleKeys = {
          "<C-d>" = true;
          "<C-f>" = false;
          "<C-s>" = false;
          "<C-z>" = false;
        };

        insertModeKeyBindingsNonRecursive = [
          { before = [ "j" "k" ]; after = [ "<Esc>" "l" ]; }
        ];

        # Plugins
        camelCaseMotion.enable = true;
        highlightedyank.enable = true;
      };

      typescript = {
        updateImportsOnFileMove.enabled = "always";
      };

      # Turn off stupid auto-formatter that breaks files
      "[less]" = {
        editor.formatOnSave = false;
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
