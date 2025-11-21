{
  flake.modules.homeManager.messaging = {pkgs, ...}: {
    home.packages = with pkgs; [
      vesktop
    ];
  };

  flake.modules.nixos.messaging = {
    preserve.users.directories = [".config/vesktop"];
  };
}
