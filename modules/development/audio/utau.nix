{
  flake.modules.homeManager.development = {pkgs, ...}: {
    home.packages = [
      (pkgs.openutau.overrideAttrs (prev: {
        version = "0.1.567";
        src = prev.src.override {
          hash = "sha256-tjW1xmt409AlEmw/N1RG46oigP4mWAoTecQGV/hwMo4=";
        };
      }))
    ];
  };

  flake.modules.nixos.development = {
    preserve.users.directories = [
      ".local/share/OpenUtau"
    ];
  };
}
