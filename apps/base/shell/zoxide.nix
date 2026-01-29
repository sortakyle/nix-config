{
  flake.modules.homeManager.base = {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd" # replaces "cd"
      ];
    };

    home.preserve.directories = [".local/share/zoxide"];
  };
}
