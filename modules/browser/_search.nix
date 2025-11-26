{
  flake.modules.homeManager.desktop = {
    programs.firefox.profiles.default.search = {
      force = true;
      default = "kagi";
      engines = {
        # don't need these default ones
        amazondotcom-us.metaData.hidden = true;
        bing.metaData.hidden = true;
        ebay.metaData.hidden = true;
        google.metaData.hidden = true;
        kagi = {
          name = "Kagi";
          urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
          iconMapObj."32" = "https://kagi.com/favicon.ico";
          definedAliases = ["@k"];
        };
      };
    };
  };
}
