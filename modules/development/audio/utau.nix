{
  flake.modules.homeManager.development = {pkgs, ...}: {
    home.packages = with pkgs; [
      openutau
    ];
  };

  flake.modules.nixos.development = {
    preserve.users.directories = [
      ".config/OpenUtau"
      ".local/share/OpenUtau"
    ];
  };
}
