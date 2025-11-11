{ lib, ... }:
{
  hosts.options.preservation = {
    enable = lib.mkEnableOption "Enable preservation for /persist persistence directory";
  };
}