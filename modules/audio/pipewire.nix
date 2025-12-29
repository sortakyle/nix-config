{
  flake.modules.nixos.audio = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      pulseaudio # provides pactl which is required by some apps
    ];

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    # Disable pulseaudio
    services.pulseaudio.enable = false;

    services.pipewire.wireplumber.extraConfig = {
      # disable HD audio & HDMI devices
      "51-disable-hdmi-devices" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {"device.name" = "alsa_card.pci-0000_f3_00.1";}
              {"device.name" = "alsa_card.pci-0000_21_00.7";}
              {"device.nick" = "HDA ATI HDMI";}
              {"device.nick" = "HD-Audio Generic";}
            ];
            actions = {
              update-props = {
                "device.disabled" = true;
              };
            };
          }
        ];
      };

      # discord prevent mic auto adjust
      "99-stop-microphone-auto-adjust" = {
        "access.rules" = [
          {
            matches = [
              {"application.process.binary" = "discord";}
            ];
            actions = {
              update-props = {
                default_permissions = "rx";
              };
            };
          }
        ];
      };
    };
  };

  flake.modules.homeManager.audio = {};
}
