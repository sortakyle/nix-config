{config, ...}: {
  hosts.nixos.mars.modules = with config.flake.modules.nixos; [
    user-kyle
    facter
  ];

  hosts.nixos.mars.users = {
    kyle.modules = with config.flake.modules.homeManager; [
      user-kyle
    ];
  };
}
