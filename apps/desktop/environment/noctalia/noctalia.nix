{inputs, ...}: {
  flake.modules.nixos.desktop-noctalia = {};

  flake.modules.homeManager.desktop-noctalia = {pkgs, ...}: {
    imports = [inputs.noctalia.homeModules.default];

    home.packages = with pkgs; [
      cliphist
      mutagen
      cava
    ];

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
      settings.appLauncher.useApp2Unit = true;
    };
  };
}
