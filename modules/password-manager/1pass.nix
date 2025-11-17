{
  flake.modules.nixos.password-manager = {
    programs._1password.enable = true;

    # TODO: enable gui if desktop enabled?

    preserve.users.directories = [
      {
        directory = ".config/op";
        mode = "0700";
      }
    ];
  };
}
