{config, ...}: {
  hosts.nixos.caprica.modules = with config.flake.modules.nixos; [
    audio
    user-kyle
    zfs
    desktop
    programs
    browser
    gaming
    yubikey
  ];

  hosts.nixos.caprica.users = {
    kyle.modules = with config.flake.modules.homeManager; [
      audio
      user-kyle
      desktop
      programs
      development
      messaging
      browser
      gaming
      yubikey
    ];
  };
}
