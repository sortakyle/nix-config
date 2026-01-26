{
  flake.modules.nixos.base.security = {
    # switch to rust-based sudo implementation
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false; # Use 'sudo' without a password
    };

    # increase file handle limits for sudoers
    pam.loginLimits = [
      {
        domain = "@wheel";
        item = "nofile";
        type = "soft";
        value = "524288";
      }
      {
        domain = "@wheel";
        item = "nofile";
        type = "hard";
        value = "1048576";
      }
    ];

    # realtime scheduling priority to user processes on demand.
    rtkit.enable = true;

    # more granular permission management
    polkit.enable = true;
  };
}
