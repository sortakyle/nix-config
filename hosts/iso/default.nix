{
  hosts.nixos.iso.module = {
    lib,
    pkgs,
    ...
  }: {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    isoImage = {
      makeEfiBootable = true;
      makeUsbBootable = true;
      squashfsCompression = "zstd -Xcompression-level 3";
    };

    systemd = {
      services.sshd.wantedBy = lib.mkForce ["multi-user.target"];
      targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
        hybrid-sleep.enable = false;
      };
    };

    users.users.kyle = {
      initialPassword = "bootstrap";
      hashedPasswordFile = lib.mkForce null;
    };

    networking = {
      hostName = "iso";
      nameservers = [
        "192.168.1.1"
      ];
      wireless.enable = lib.mkForce false;
    };
    services.resolved.settings.Resolve.FallbackDNS = [
      "1.1.1.1"
      "2606:4700:4700::1111"
    ];

    # Utilities necessary for bootstrap but not desired to be included in base
    environment.systemPackages = with pkgs; [
      disko
      nixos-facter
    ];
  };
}
