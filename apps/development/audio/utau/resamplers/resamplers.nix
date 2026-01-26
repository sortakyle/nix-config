{
  flake.modules.homeManager.development = {pkgs, ...}: let
    libgvps = pkgs.stdenv.mkDerivation rec {
      name = "libgvps";
      src = pkgs.fetchFromGitHub {
        owner = "Sleepwalking";
        repo = name;
        rev = "2f1b4106d72f8f8138dc447bf0123820c0772cbd";
        hash = "sha256-8NRn3cs30aDam/3bXytwJUFkbJvP6/N2DXLPjDKleYQ=";
      };

      installPhase = ''
        runHook preInstall
        make PREFIX=$out install
        runHook postInstall
      '';
    };

    libpyin = pkgs.stdenv.mkDerivation rec {
      name = "libpyin";
      src = pkgs.fetchFromGitHub {
        owner = "Sleepwalking";
        repo = name;
        rev = "b38135390b335c3e8cea6ef35cf5093789b36dac";
        hash = "sha256-rgVhzAnNwbOxW3k6nq5jP1ZL7uxfTgydlN7spWozG1U=";
      };

      patches = [./libpyin.patch];

      buildPhase = ''
        runHook preBuild
        make GVPS_PREFIX=${libgvps}
        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall
        make PREFIX=$out install
        runHook postInstall
      '';
    };

    macres = pkgs.stdenv.mkDerivation rec {
      pname = "macres";
      version = "v0.2.1";

      src = pkgs.fetchFromGitHub {
        owner = "titinko";
        repo = "macres";
        tag = version;
        hash = "sha256-UTwzjn35N7tWxEgwTFvYaRb/LVKta+Bv4ysxZcAjoUA=";
      };
      sourceRoot = "${src.name}/src";

      buildPhase = ''
        runHook preBuild
        make LIB_PREFIX=$deps macres
        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall
        mkdir -p $out/utau/resamplers
        cp macres $out/utau/resamplers/
        runHook postInstall
      '';

      deps = pkgs.buildEnv {
        name = "macres-lib";
        paths = [libgvps libpyin];
      };
    };
  in {
    xdg.dataFile."OpenUtau/Resamplers".source = let
      combinedDrv = pkgs.buildEnv {
        name = "openutau-resamplers";
        paths = [
          macres
        ];
      };
    in "${combinedDrv}/utau/resamplers";
  };
}
