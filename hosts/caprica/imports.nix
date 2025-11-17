{config, ...}: {
  hosts.nixos.caprica.modules = with config.flake.modules.nixos; [
    user-kyle
    zfs
    password-manager
  ];

  hosts.nixos.caprica.users = {
    kyle.modules = with config.flake.modules.homeManager; [
      user-kyle
    ];
  };
}
