{ self, config, ... }: {
  flake.modules.homeManager.terminal-latex = { pkgs, config, ... }: {
    home.packages = with pkgs; [
      texlab
      texlive.combined.scheme-full
      tex-fmt
      ltex-ls-plus
    ];

    home.file.".indentconfig.yaml".source = (pkgs.formats.yaml {}).generate "" {
      paths = [
        ''${config.home.homeDirectory}/.latexindent.yaml''
      ];
    };

    home.file.".latexindent.yaml".source = (pkgs.formats.yaml {}).generate "" {
      defaultIndent = "    ";
    };
  };
}
