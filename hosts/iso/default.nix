{lib, pkgs, ...}: {
  hosts.nixos.iso.module = {
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
      wireless.enable = false;
    };
    services.resolved.fallbackDns = ["1.1.1.1" "2606:4700:4700::1111"];

    environment.systemPackages = with pkgs; [
      yq-go
      sanoid
    ];
  };
}