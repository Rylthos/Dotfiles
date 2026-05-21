hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 5,
        border_size = 1,

        col = {
            active_border = {
                colors = {
                    "rgba(FF0000CC)",
                    "rgba(FF8700CC)",
                    "rgba(FFD300CC)",
                    "rgba(DEFF0ACC)",
                    "rgba(A1FF0ACC)",
                    "rgba(0AFF99CC)",
                    "rgba(0AEFFFCC)",
                    "rgba(147DF5CC)",
                    "rgba(580AFFCC)",
                    "rgba(BE0AFFCC)"
                },
                angle = 90
            };
            inactive_border = {
                colors = {
                    "rgba(147DF588)"
                },
                angle =  45,
            };
        },

        layout = "hy3",
    },

    misc = {
        disable_hyprland_logo = true,
        vrr = true,
    },

    render = {
        cm_enabled = false,
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled = true,
            size = 8,
            passes = 2,
        },

        shadow = {
            enabled = true,
            range = 4,
        },
    },

    gestures = {
        workspace_swipe_touch = true,
        workspace_swipe_cancel_ratio = 0.3,
    };

    plugin = {
        hy3 = {
            autotile = {
                enable = true,
                trigger_width = 800,
                trigger_height = 600,
            },
        },
    },
})
