{
  flake.modules.nixos.base = {
    # Don't allow mutation of users outside configs
    users.mutableUsers = false;
  };
}
