{inputs, ...}: let
  # Generated from
  # uuidgen --sha1 --namespace 630fcd67-0fe3-4d26-9998-ebd4f9179ab4 --name
  extensionsMap = {
    "uBlock0@raymondhill.net" = "f2dfe198-4359-520e-ad8d-dce5d072da82";
    "{d634138d-c276-4fc8-924b-40a0ea21d284}" = "fcd36c08-28c7-54aa-b16d-15b9b4f94e86";
  };
  extensionUuidList = builtins.attrValues extensionsMap;
in {
  flake.modules.nixos.browser = {lib, ...}: {
    # Overlay NUR to enable unfree firefox addons (1pass)
    nixpkgs.overlays = [inputs.nur.overlay];

    # extensions use sqlite databases based on the uuid assigned to them
    preserve.users.directories = let
      prefix = ".mozilla/firefox/default/storage/default";
      extensionDirs = uuid: [
        "${prefix}/moz-extension+++${uuid}"
        "${prefix}/moz-extension+++${uuid}^userContextId=4294967295"
      ];
    in
      lib.lists.flatten (builtins.map extensionDirs extensionUuidList);
  };

  flake.modules.homeManager.browser = {
    pkgs,
    lib,
    ...
  }: {
    programs.firefox.profiles.default = {
      extensions = {
        force = lib.mkForce true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          onepassword-password-manager
        ];
      };

      settings = {
        "extensions.webextensions.uuids" = extensionsMap;
      };
    };
  };
}
