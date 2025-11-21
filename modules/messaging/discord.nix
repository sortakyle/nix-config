{
  flake.modules.homeManager.messaging = {pkgs, ...}: {
    home.packages = with pkgs; [
      pkgs.discord
      pkgs.vesktop
    ];
  };

  flake.modules.nixos.messaging = {
    preserve.users.directories = [
      ".config/discord"
      ".config/vesktop"
    ];
  };
}
