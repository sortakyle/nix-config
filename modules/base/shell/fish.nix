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

    preserve.users.directories = [".local/share/fish"];
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
        babylon-wake = "wakeonlan -i 255.255.255.255 34:5a:60:61:8e:ea";
      };
    };
  };
}
