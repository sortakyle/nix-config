{inputs, ...}: {
  flake.modules.homeManager.desktop-dms = {lib, ...}: {
    imports = [inputs.catppuccin.homeModules.catppuccin];

    catppuccin = {
      accent = "mauve";
      flavor = "mocha";

      # Applications that we want to use catppuccin instead of stylix
      # vesktop.enable = true;
      thunderbird.enable = true;
      fish.enable = true;
      ghostty.enable = true;
      bat.enable = true;
      vscode.profiles.default = {
        enable = true;
        icons.enable = true;
      };

      hyprland.enable = true;
    };

    stylix.targets = {
      bat.enable = lib.mkForce false;
    };
    stylix.targets.fish.enable = lib.mkForce false;
    stylix.targets.ghostty.enable = lib.mkForce false;
  };
}
