{
  flake.modules.nixos.development = {
    # preserve.users.directories = [".vscode"];
  };

  flake.modules.homeManager.development = {
    pkgs,
    lib,
    ...
  }: {
    home.sessionVariables = {
      EDITOR = "code";
      VISUAL = "code";
    };

    xdg.mimeApps.defaultApplications = {
      "text/plain" = ["code.desktop"];
      "application/x-wine-extension-ini" = ["code.desktop"];
      "x-scheme-handler/vscode" = ["code.desktop"];
    };

    # Using the catppuccin vsc extension instead
    stylix.targets.vscode.enable = false;

    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          ms-ceintl.vscode-language-pack-ja
        ];
        userSettings = {
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
            "editor.formatOnSave" = true;
          };
          "editor.fontFamily" = "'Fira Code','Noto Sans'";
          "editor.bracketPairColorization.enabled" = true;
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.guides.bracketPairs" = true;
          "editor.inlineSuggest.enabled" = true;
          "editor.inlineSuggest.edits" = {
            renderSideBySide = true;
          };
          "editor.renderWhitespace" = "boundary";
          "editor.suggestFontSize" = 0;
          "editor.suggest.preview" = true;
          "editor.suggest.showStatusBar" = true;
          "editor.mouseWheelZoom" = true;
          "editor.rulers" = [100];
          "editor.stickyScroll.enabled" = true;
          "editor.stickyScroll.maxLineCount" = 10;
          "editor.suggestSelection" = "first";
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.fileNesting.enabled" = true;
          "explorer.fileNesting.patterns" = {
            "*.md" = "\${capture}.*.md";
            "config.toml" = "config.*.toml,params.toml";
          };
          "extensions.autoCheckUpdates" = false;
          "extensions.autoUpdate" = false;
          "extensions.ignoreRecommendations" = true;
          "files.autoSave" = "afterDelay";
          "files.autoSaveDelay" = 500;
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;
          "files.enableTrash" = false;
          "files.autoGuessEncoding" = true;
          "git.allowForcePush" = true;
          "git.autofetch" = true;
          "git.autoStash" = true;
          "git.blame.editorDecoration.enabled" = true;
          "git.blame.statusBarItem.enabled" = true;
          "git.blame.editorDecoration.template" = "\${subject}, \${authorName} (\${authorDateAgo})";
          "git.blame.statusBarItem.template" = "\${subject}, \${authorName} (\${authorDateAgo})";
          "git.confirmForcePush" = false;
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "git.showPushSuccessNotification" = true;
          "githubPullRequests.pullBranch" = "always";
          "nix.formatterPath" = [(lib.getExe pkgs.alejandra)];
          "nix.serverPath" = lib.getExe pkgs.nixd;
          "nix.enableLanguageServer" = true;
          "nix.serverSettings".nixd.formatting.command = [(lib.getExe pkgs.alejandra)];
          "search.seedWithNearestWord" = true;
          "search.showLineNumbers" = true;
          "search.useGlobalIgnoreFiles" = true;
          "search.useIgnoreFiles" = true;
          "search.exclude" = {
            "**/.direnv" = true;
            "**/.git" = true;
            "**/.jj" = true;
            "**/.venv" = true;
            "**/node_modules" = true;
            "*.lock" = true;
            "dist" = true;
            "tmp" = true;
          };
          "security.workspace.trust.enabled" = false;
          "security.workspace.trust.untrustedFiles" = "open";
          "telemetry.telemetryLevel" = "off";
          "terminal.integrated.defaultProfile.linux" = "fish";
          "terminal.integrated.tabs.enabled" = true;
          "update.mode" = "none";
          "update.showReleaseNotes" = true;
          "window.dialogStyle" = "custom";
          "window.menuBarVisibility" = "toggle";
          "window.newWindowDimensions" = "inherit";
          "window.titleBarStyle" = "custom";
          "window.zoomLevel" = 0;
          "window.confirmSaveUntitledWorkspace" = false;
          "workbench.colorCustomizations" = {};
          "workbench.commandPalette.experimental.suggestCommands" = true;
          "workbench.editor.enablePreview" = true; # Prevents temporary editor tabs
          "workbench.editor.highlightModifiedTabs" = true;
          "workbench.panel.defaultLocation" = "bottom";
          "workbench.startupEditor" = "none";
        };
      };
    };
  };
}
