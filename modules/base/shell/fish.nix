{
  flake.modules.nixos.base = {
    programs.fish = {
      enable = true;
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
    };
  };

  flake.modules.homeManager.base = {
    programs.fish = {
      enable = true;
      functions = {
        fish_greeting = "";
      };
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        cat = "bat";
        ls = "eza";
        grep = "rg";
      };
    };
  };
}
