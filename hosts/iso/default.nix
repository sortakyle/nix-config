{config, inputs, lib, ...}: {
  hosts.nixos.iso.module = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    isoImage = {
      makeEfiBootable = true;
      makeUsbBootable = true;
      squashfsCompression = "zstd -Xcompression-level 3";
    };

    imports = with config.flake.modules.nixos; [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      core
    ];
  };
}