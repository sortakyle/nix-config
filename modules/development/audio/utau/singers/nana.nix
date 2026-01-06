{
  flake.modules.homeManager.development = {pkgs, ...}: let
    files = pkgs.fetchzip {
      url = "https://nanahira.jp/haruka_nana/data/renzokuon_2023.zip";
      hash = "";
    };
  in {
    # 1. fetchzip
    # 2. create character.yaml
    # 3. bundle into single drv
    # 4. link source

    xdg.dataFile."OpenUtau/SingersTest/HarukaNana_2023ver".source = files;
  };
}
