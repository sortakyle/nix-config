{
  hosts.nixos.caprica.module = {
    system.stateVersion = "25.11";
    home-manager.sharedModules = [{home.stateVersion = "25.11";}];

    # services.getty.autologinUser = "kyle";
    programs.nh.flake = "/home/kyle/.nix-config";
  };
}
