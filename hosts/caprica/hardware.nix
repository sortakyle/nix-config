{
  hosts.nixos.caprica.module = {inputs, ...}: {
    imports = [inputs.nixos-facter-modules.nixosModules.facter];
    facter.reportPath = ./facter.json;
  };
}
