{inputs, ...}: {
  hosts.nixos.caprica.module = {
    imports = [inputs.nixos-facter-modules.nixosModules.facter];
    facter.reportPath = ./facter.json;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
