{
  flake.modules.homeManager.audio = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = lib.map pkgs.lazy-app.override (with pkgs; [
      {pkg = qpwgraph;}
      {pkg = d-spy;}
      {
        pkg = gnome-disk-utility;
        exe = "gnome-disks";
      }
    ]);
  };
}
