{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.firefox;
in {
    options.modules.firefox = { enable = mkEnableOption "firefox"; };
    config = mkIf cfg.enable {
      programs.firefox = {
        enable = true;

        profiles = {
          aaron = {
            id = 0;
            name = "aaron";
            isDefault = true;
            settings = {
              "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
              "browser.startup.homepage" = "https://nixos.org";
            };
            search = {
              force = true;
              default = "DuckDuckGo";
              engines = {
                "Nix Packages" = {
                  urls = [{
                    template = "https://search.nixos.org/packages";
                    params = [
                      { name = "type"; value = "packages"; }
                      { name = "query"; value = "{searchTerms}"; }
                    ];
                  }];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@np" ];
                };
                "MyNixOS" = {
                  urls = [{
                    template = "https://mynixos.com/search?q={searchTerms}";
                  }];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@mn" ];
                };
                "Wikipedia" = {
                  urls = [{
                    template = "https://en.wikipedia.org/wiki/{searchTerms}";
                  }];
                  definedAliases = [ "@wi" ];
                };
              };
            };
            extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            '';
            userChrome = ''
            .titlebar-buttonbox-container{ display:none }
            '';
          };
        };
      };
    };
  }
