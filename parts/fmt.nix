{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.git-hooks.flakeModule
  ];

  perSystem = {self', ...}: {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        jsonfmt.enable = true;
        prettier.enable = true;
        shfmt.enable = true;
        statix.enable = true;
        yamlfmt.enable = true;
      };
      settings = {
        on-unmatched = "fatal";
        global.excludes = [
          "*.envrc"
          ".editorconfig"
          "*.directory"
          "*.face"
          "*.fish"
          "*.png"
          "*.jpg"
          "*.toml"
          "*.svg"
          "*.xml"
          "*.pub"
          "*.ustx"
          "*.colortheme"
          "*/.gitignore"
          "LICENSE"
        ];
      };
    };

    pre-commit.settings.hooks.nix-fmt = {
      enable = false;
      entry = lib.getExe self'.formatter;
    };
  };
}
