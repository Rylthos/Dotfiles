{ self, ... }: {
  flake.modules.nixos.desktop-firefox = { pkgs, ... }: {
    environment = {
      variables = {
        MOZ_ENABLE_WAYLAND = "1";
      };

      sessionVariables = {
        MOZ_USE_XINPUT2 = "1";
      };
    };
  };

  flake.modules.homeManager.desktop-firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;

      profiles = {
        aaron = {
          id = 0;
          name = "aaron";
          isDefault = true;
          settings = {
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "dark-fox-anniversary";
            "browser.startup.homepage" = "https://nixos.org";
            "sidebar.verticalTabs" = true;
          };
          search = {
            force = true;
            default = "ddg";
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
