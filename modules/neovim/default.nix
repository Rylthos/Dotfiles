{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.neovim;
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
                nvim-treesitter.withAllGrammars
            ];

            extraPackages = with pkgs; [ gcc ];
        };

        xdg.configFile."nvim/lua" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/neovim/nvim/lua";
            recursive = true;
        };

        xdg.configFile = {
            "nvim/init.lua".text = ''
                vim.opt.runtimepath:append("${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}")

                require('start')
            '';
        };
    };
}
