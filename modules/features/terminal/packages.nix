{ self, ... }: {
  flake.modules.homeManager.terminal-packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      feh
      imv

      btop
      p7zip
      wget
      octave
      ffmpeg

      imhex

      imagemagick
      pandoc
      playerctl

      evtest
      perl

      eza
      bat
      ripgrep
      fd
      fzf
      dua

      mosh

      dateutils
    ];
  };
}
