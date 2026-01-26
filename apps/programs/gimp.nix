{
  flake.modules.homeManager.programs = {pkgs, ...}: {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
