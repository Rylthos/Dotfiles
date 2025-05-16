{ inputs, pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.tauon;
    tekore = pkgs.python312Packages.buildPythonPackage rec {
        pname = "tekore";
        version = "6.0.0";
        format = "pyproject";

        src = pkgs.python312Packages.fetchPypi {
            inherit version;
            inherit pname;
            sha256 = "sha256-34fiZPzxjC1yrgFPlY3GXGyAd10FqUakZNdr+Me/BHY=";
        };

        nativeBuildInputs = with pkgs.python312Packages; [
            setuptools
                wheel
        ];

        buildInputs = with pkgs.python312Packages; [
            httpx
                pydantic
        ];
    };
in {
    options.modules.tauon = { enable = mkEnableOption "tauon"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            (tauon.overrideAttrs (prevAttrs: {
                pythonRemoveDeps = [
                    "pysdl2-dll"
                    "opencc"
                  ];
                  buildInputs = prevAttrs.buildInputs ++ [ tekore ];
                  pythonPath = prevAttrs.pythonPath ++ [ tekore ];
            }))
        ];
    };
}
