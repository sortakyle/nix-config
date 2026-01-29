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

    xdg.dataFile = {
      "OpenUtau/Templates/default.ustx".source = ./default.ustx;
      "OpenUtau/Resamplers".source = let
        combinedDrv = pkgs.buildEnv {
          name = "openutau-resamplers";
          paths = [
            pkgs.local."openutau-resamplers/macres"
          ];
        };
      in "${combinedDrv}/utau/resamplers";
    };

    home.preserve.directories = [".local/share/OpenUtau"];
  };
}
