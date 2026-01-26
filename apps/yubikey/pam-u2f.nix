{
  flake.modules.nixos.yubikey = {
    pkgs,
    config,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      pam_u2f
    ];

    security.pam = {
      u2f = {
        enable = true;
        settings = {
          authfile = config.sops.secrets.u2f-mappings.path;
          cue = true;
          appid = "pam://u2f.kyle.fail";
          origin = "pam://u2f.kyle.fail";
        };
      };

      services = {
        hyprlock.u2fAuth = true;
        login.u2fAuth = true;
        login.rules.auth.u2f = {
          control = lib.mkForce "sufficient";
        };
        login.enableGnomeKeyring = lib.mkForce false;

        greetd.u2fAuth = true;
        greetd.rules.auth.u2f = {
          control = lib.mkForce "sufficient";
        };
        sudo.u2fAuth = true;
        polkit-1.u2fAuth = true;
      };
    };

    sops.secrets.u2f-mappings = {
      sopsFile = ./u2f-mappings.sops.yaml;
      path = "/etc/u2f_mappings";
      mode = "0444";
    };
  };

  flake.modules.homeManager.yubikey = {};
}
