{
  flake.modules.homeManager.base = {lib, ...}: {
    # What are the default editors to launch with any program
    home.sessionVariables = {
      EDITOR = lib.mkDefault "micro";
      VISUAL = lib.mkDefault "micro";
    };
  };
}
