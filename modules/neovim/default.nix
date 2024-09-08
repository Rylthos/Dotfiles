{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.neovim;

treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.c
    p.cpp
    p.css
    p.fish
    p.gitattributes
    p.gitignore
    p.javascript
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.vim
    p.vimdoc
    p.ocaml
]));

treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
};
in {
    options.modules.neovim = { enable = mkEnableOption "neovim"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [ ripgrep fd ];

        programs.neovim = {
            enable = true;
            vimAlias = true;
            viAlias = true;

            withNodeJs = true;

            plugins = with pkgs.vimPlugins; [
                nvim-treesitter
                treesitterWithGrammars
            ];

            extraPackages = with pkgs; [ gcc ];
        };

        xdg.configFile."nvim/parser".source = "${pkgs.symlinkJoin {
            name = "treesitter-parsers";
            paths = treesitterWithGrammars.dependencies;
        }}/parser";

        xdg.configFile.nvim = {
            source = ./nvim;
            recursive = true;
        };
    };
}
