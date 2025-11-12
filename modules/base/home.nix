{
  flake.modules.homeManager.base = {
    programs.home-manager.enable = true;

    # Unsure if actually needed, commenting out for now
    #home.sessionPath = [ "$HOME/.local/bin" ];

    services = {
      home-manager.autoExpire = {
        enable = true;
        frequency = "weekly";
        store.cleanup = true;
      };
    };
  };
}
