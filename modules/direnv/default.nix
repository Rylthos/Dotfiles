{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.direnv;
in {
    options.modules.direnv = { enable = mkEnableOption "direnv"; };
    config = mkIf cfg.enable {
    	home.packages = with pkgs; [
	    direnv
	];
        
        programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
            enableBashIntegration = true;
        };

        programs.fish = {
            interactiveShellInit = mkAfter "direnv hook fish | source\n";
        };
    };
}
