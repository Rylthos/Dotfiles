hl.window_rule({ match = { initial_class = "GLFW" }, float=true, opaque=true, render_unfocused=true })

hl.window_rule({ match = { initial_class = "Alacritty" }, opacity="0.93 0.65" })

hl.window_rule({ match = { class = "ord.kde.digikam", title = "^New Album" }, float=true })

hl.window_rule({
    name = "floating firefox window - resize and center";
    match = {
        class = "firefox",
        float = true,
    },
    size = "(0.5*monitor_w) (0.5*monitor_h)",
    center = true
})

hl.window_rule({
    name = "Position PiP firefox";

    match = {
        class = "firefox";
        title = "Picture-in-Picture";
    },

    float = true,
    pin = true,
    move = "(0.7*monitor_w-5) (0.05*monitor_h+5)",
    size = "(0.3*monitor_w) (0.3*monitor_h)",
})

hl.window_rule({
    name = "Position PiP Discord";

    match = {
        class = "vesktop",
        initial_title = "(Discord Popout)",
    },

    float = true,
    pin = true,
    move = "(0.8*monitor_w) (0.05*monitor_h)",
    persistent_size = true,
})

hl.window_rule({
    name = "Position Pavu control";

    match = { class = "(com.saivert.pwvucontrol)" },

    float = true,
    center = true,
    persistent_size = true,
    size = "(0.6*monitor_w) (0.6*monitor_h)",
})

hl.window_rule({
    name = "Position blueman manager";

    match = { class = ".blueman-manager-wrapped" },

    float = true,
    center = true,
    size = "(0.6*monitor_w) (0.6*monitor_h)",
})

hl.window_rule({
    name = "Position nm-connection-editor",

    match = { class = "nm-connection-editor" },

    float = true,
    center = true,
    size = "(0.6*monitor_w) (0.6*monitor_h)",
})

hl.window_rule({ match = { class="tracy" }, render_unfocused=true })

hl.window_rule({
    name = "Fix steam games",

    match = { class = "(^steam_app_[0-9]*)" },

    render_unfocused = true,
    fullscreen = true,
    idle_inhibit = "focus",
})
