{ self, ... }: {
  flake.modules.homeManager.terminal-python = { pkgs, ... }: {
    home.packages = with pkgs; [
      (pkgs.python313.withPackages (ppkgs: [
                                    ppkgs.matplotlib
                                    ppkgs.numpy
                                    ppkgs.scipy
                                    ppkgs.pyserial
                                    ppkgs.ipython
                                    ppkgs.pygments
                                    ppkgs.pillow
                                    ppkgs.opencv-python
                                    ppkgs.ipython
      ]))
    ];
  };
}
