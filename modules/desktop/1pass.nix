{
  flake.modules.nixos.desktop = _: {
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
}
