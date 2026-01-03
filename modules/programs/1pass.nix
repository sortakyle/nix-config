{
  flake.modules.nixos.programs = {
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

  flake.modules.homeManager.programs = {
    # For desktop users, enable 1pass as the default SSH agent
    # NOTE: the ssh agent needs to be manually started in the 1pass gui once
    programs.ssh = {
      matchBlocks = {
        "*" = {
          identityAgent = "~/.1password/agent.sock";
        };
      };
    };

    # Hyprland configuration options + bindings
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "sleep 1 && app2unit -s s -- 1password --silent"
      ];

      windowrule = [
        "float on, match:class 1password"
      ];

      bind = [
        "CTRL SHIFT, Space, exec, app2unit -- 1password --quick-access"
      ];
    };
  };
}
