local hy3 = hl.plugin.hy3

local hs = require("plugins.hyprsplit")

local mod = "SUPER";

local terminal = "alacritty"
local fileManager = "thunar"

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("xournalpp"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("$NIXOS_SCRIPTS_DIR/AppLauncher.sh"))

hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. "+ F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + P", hl.dsp.window.pin())

hl.bind("CONTROL + ALT + DELETE", hl.dsp.exec_cmd("wlogout -b 4 -s -c 10 -T 400 -L 410 -R 410 -B 400"))

hl.bind("Print", hl.dsp.exec_cmd("$NIXOS_SCRIPTS_DIR/Screenshot.sh"))

hl.bind(mod .. " + h", hy3.move_focus("l", { visible = true }))
hl.bind(mod .. " + l", hy3.move_focus("r", { visible = true }))
hl.bind(mod .. " + k", hy3.move_focus("u", { visible = true }))
hl.bind(mod .. " + j", hy3.move_focus("d", { visible = true }))

hl.bind(mod .. " + SHIFT + H", hy3.move_window("l", { once = true }))
hl.bind(mod .. " + SHIFT + L", hy3.move_window("r", { once = true }))
hl.bind(mod .. " + SHIFT + K", hy3.move_window("u", { once = true }))
hl.bind(mod .. " + SHIFT + J", hy3.move_window("d", { once = true }))

hs.config({ num_workspaces = 10 })
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hs.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hs.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. "+ g", hs.dsp.grab_rogue_windows())
hl.bind(mod .. "+ d", hs.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))

hl.bind(mod .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. "+ mouse:273", hl.dsp.window.resize(), { mouse = true })
