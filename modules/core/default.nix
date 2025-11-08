{
  flake.modules.nixos.core = {...}: {
    users.mutableUsers = false;
  };
}