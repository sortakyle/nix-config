{
  flake.modules.nixos.base = {pkgs, ...}: {
    users.defaultUserShell = pkgs.fish;
  };

  flake.modules.homeManager.base = {pkgs, ...}: {
    home.shell.enableFishIntegration = true;

    home.packages = with pkgs;
      [
        bat # cat alternative with auto pager
        dust # du alternative
        eza # ls alternative
        fd # find alternative
        fselect # file finder with sql-ish syntax
        glances # system monitor
        jq # json parsing
        ouch # file compression / decompression
        ripgrep # grep alternative
        yq-go # yaml parsing / editing

        alejandra # nix formatter
        nixd # nix lsp

        wakeonlan # necessary for home lab maintenance
      ]
      ++ lib.map lazy-app.override [
        {pkg = dmidecode;}
        {
          pkg = pciutils;
          exe = "lspci";
        }
        {
          pkg = usbutils;
          exe = "lsusb";
        }
      ];

    stylix.targets.bat.enable = true;
  };
}
