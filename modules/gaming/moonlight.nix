{
  flake.modules.homeManager.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      moonlight-qt
    ];
  };

  flake.modules.nixos.gaming = {
    preserve.users.files = [".config/Moonlight Game Streaming Project/Moonlight.conf"];
  };
}
