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
        fselect # file finder with sql-ish syntax
        glances # system monitor
        jq # json parsing
        ouch # file compression / decompression
        ripgrep # grep alternative
        yq-go # yaml parsing / editing
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
  };
}
