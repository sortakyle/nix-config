{
  flake.modules.homeManager.development = {pkgs, ...}: let
    name = "openutau-singer-haruka-nana-v2023";

    character = (pkgs.formats.yaml {}).generate "${name}-character.yaml" {
      name = "春歌ナナ連続音_2023ver";
      localized_names = {
        en-US = "Haruka Nana (2023 version)";
      };
      singer_type = "utau";
      text_file_encoding = "shift_jis";
      image = "image.bmp";
      author = "ななひら";
      voice = "ななひら";
      version = "2023";
      web = "https://nanahira.jp/haruka_nana/index.html";
      default_phonemizer = "OpenUtau.Plugin.Builtin.JapanesePresampPhonemizer";
    };
  in {
    xdg.dataFile."OpenUtau/Singers/春歌ナナ連続音_2023ver".source = pkgs.stdenvNoCC.mkDerivation {
      inherit name;

      src = pkgs.fetchzip {
        url = "https://nanahira.jp/haruka_nana/data/renzokuon_2023.zip";
        hash = "sha256-2pM0O0G6lX/0cHL5TchMSNe2Pgc1kpsqjg+AQxf50Q4=";
      };

      installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp -R $src/* $out/
        cp ${character} $out/character.yaml

        runHook postInstall
      '';
    };
  };
}
