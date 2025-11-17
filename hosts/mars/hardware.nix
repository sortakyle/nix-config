{
  hosts.nixos.mars.module = {inputs, ...}: {
    imports = [inputs.nixos-facter-modules.nixosModules.facter];
    facter.reportPath = ./facter.json;
  };
}
