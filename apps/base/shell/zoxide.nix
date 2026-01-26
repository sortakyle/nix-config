{
  flake.modules.nixos.base = {
    preserve.users.directories = [".local/share/zoxide"];
  };

  flake.modules.homeManager.base = {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd" # replaces "cd"
      ];
    };
  };
}
