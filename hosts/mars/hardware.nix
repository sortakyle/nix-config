{inputs, ...}: {
  hosts.nixos.mars.module = {
    imports = [inputs.nixos-facter-modules.nixosModules.facter];
    facter.reportPath = ./facter.json;
  };
}
