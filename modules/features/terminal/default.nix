{ self, config, ... }: let
  modules =[
    "terminal-dev-packages"
    "terminal-direnv"
    "terminal-git"
    "terminal-latex"
    "terminal-packages"
    "terminal-python"
    "terminal-neovim"
    "terminal-ssh"
    "terminal-starship"
    "terminal-tmux"
    "terminal-yazi"
    "terminal-zsh"
  ];
in {
  flake.modules = self.lib.groupPackages config modules "terminal";
}
