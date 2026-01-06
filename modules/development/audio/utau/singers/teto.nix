{
  flake.modules.homeManager.development = {pkgs, ...}: {
    xdg.dataFile."OpenUtau/Singers/重音テト OU用日本語統合ライブラリー".source = pkgs.stdenvNoCC.mkDerivation {
      name = "openutau-singer-kasane-teto";

      src = pkgs.fetchzip {
        url = "https://kasaneteto.jp/ongendl/index.cgi/extra/TETO-OUset240323.zip";
        hash = "sha256-4kGitQsi/44RAcNHGxdkE/s1KdZhpjKRuAv9CgQCbnI=";
        stripRoot = false;
      };

      installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp -R $src/重音テト\ OU用日本語統合ライブラリー/* $out/

        runHook postInstall
      '';
    };
  };
}
