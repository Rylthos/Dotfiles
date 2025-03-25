{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.tmux;
in {
    options.modules.tmux = { enable = mkEnableOption "tmux"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [ tmux ];

	programs.tmux = {
	    enable = true;
	    shell = "${pkgs.fish}/bin/fish";
	    terminal = "tmux-256color";

	    escapeTime = 0;
	    historyLimit = 100000;
	    clock24 = true;
	    mouse = true;
	    baseIndex = 1;
	    prefix = "C-Space";
	    keyMode = "vi";
	    aggressiveResize = true;

	    plugins = with pkgs; with tmuxPlugins; [
		# vim-tmux-navigator
		{
		    plugin = catppuccin;
		    extraConfig = '' 
			set -g @catppuccin_flavour 'macchiato'
			set -g @catppuccin_window_tabs_enabled on
			set -g @catppuccin_date_time "%H:%M:%S"
		    '';
		}
		{
		    plugin = weather;
		    extraConfig = ''
			set-option -g status-right "#{weather}"
		    '';
		}
	    ];

	    extraConfig = ''
		set-option -sa terminal-override ",xterm*:Tc"

		set-option -g renumber-windows on
		set-option -g automatic-rename on

		set -s set-clipboard external

		bind -n M-H previous-window
		bind -n M-L next-window

		bind-key h select-pane -L
		bind-key j select-pane -D
		bind-key k select-pane -U
		bind-key l select-pane -R

		bind 'v' split-window -v -c "#{pane_current_path}"
		bind 'h' split-window -h -c "#{pane_current_path}"
	    '';
	};
    };
}
