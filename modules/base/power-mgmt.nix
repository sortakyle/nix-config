{
  flake.modules.nixos.base = {lib, ...}: {
    powerManagement = {
      enable = true;
      cpuFreqGovernor = lib.mkDefault "powersave";
    };
  };
}
