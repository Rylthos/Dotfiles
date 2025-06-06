{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.neovim;

treesitterGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.arduino
    p.bash
    p.c
    p.cpp
    p.css
    p.fish
    p.gitattributes
    p.gitignore
    p.glsl
    p.javascript
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.rust
    p.vim
    p.vimdoc
    p.ocaml
]));

treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterGrammars.dependencies;
};
in {
    options.modules.neovim = { enable = mkEnableOption "neovim"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            ripgrep
            fd
            tree-sitter
            fzf
            lua-language-server
        ];

        programs.neovim = {
            enable = true;
            vimAlias = true;
            viAlias = true;

            withNodeJs = true;

            plugins = with pkgs.vimPlugins; [
                nvim-treesitter
                treesitterGrammars
            ];

            extraPackages = with pkgs; [ gcc ];
        };

        xdg.configFile."nvim/after" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/neovim/nvim/after";
            recursive = true;
        };
        xdg.configFile."nvim/lua" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/neovim/nvim/lua";
            recursive = true;
        };

        xdg.configFile = {
            "nvim/init.lua".text = ''
                vim.opt.runtimepath:append("${treesitterGrammars}")
                vim.opt.runtimepath:append("${treesitter-parsers}")

                require('start')
            '';
        };
    };
}
