{
  flake.modules.nixos.desktop = {
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = ["kyle"];
    };

    preserve.users.directories = [
      {
        directory = ".config/1Password";
        mode = "0700";
      }
    ];
  };

  flake.modules.homeManager.desktop = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "app2unit -s s -- 1password --silent"
      ];
    };
  };
}
