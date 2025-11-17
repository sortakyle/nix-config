{
  flake.modules.homeManager.base = {
    # This sets up the standard XDG environment variables
    # XDG_CONFIG_HOME, XDG_CACHE_HOME, XDG_DATA_HOME, XDG_STATE_HOME
    # see: https://wiki.archlinux.org/title/XDG_Base_Directory
    #
    # We are ONLY enabling this part of xdg in base as it is applicable to both 
    # terminal and desktop environments. desktop module should enable more of xdg
    xdg.enable = true;
  };
}