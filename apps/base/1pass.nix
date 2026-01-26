{
  flake.modules.nixos.base = {
    programs._1password.enable = true;

    preserve.users.directories = [
      {
        directory = ".config/op";
        mode = "0700";
      }
    ];
  };
}
