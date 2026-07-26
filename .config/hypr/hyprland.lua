local machine = "hyprland.machine-specific."

local programs = {
    terminal = "ghostty",
    file_manager = "dolphin",
    menu = "vicinae vicinae://toggle",
    browser = "zen-browser",
    screenshot_copy = "/home/gabe/.local/bin/takeScreenshot.sh",
    screenshot_copy_quick = "grimblast --notify --freeze copy area",
    screenshot_edit = "grimblast --notify --freeze edit area",
    screenshot_save = [[grimblast --notify --freeze copysave area "$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"]],
}

local function optional_require(name)
    local ok, loaded = pcall(require, name)

    if ok then
        return loaded
    end

    if tostring(loaded):find("module '" .. name .. "' not found:", 1, true) then
        return nil
    end

    error(loaded, 0)
end

local function shell_quote(value)
    return "'" .. value:gsub("'", "'\\''") .. "'"
end

local program_overrides = optional_require(machine .. "programs")
if program_overrides then
    assert(type(program_overrides) == "table", machine .. "programs must return a table")

    for key, value in pairs(program_overrides) do
        programs[key] = value
    end
end

local machine_autostart = optional_require(machine .. "autostart")

optional_require(machine .. "monitors")

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("exec uwsm finalize")
    hl.exec_cmd("uwsm app -t service -- /usr/lib/pam_kwallet_init")
    hl.exec_cmd("uwsm app -t service -- $HOME/.config/hypr/run-in-interval.sh 900 $HOME/.config/hypr/change-wallpaper.sh")
    hl.exec_cmd("uwsm app -t service -- caelestia resizer -d")
    if type(machine_autostart) == "function" then
        machine_autostart()
    end
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "HyprBibataModernClassicSVG")
hl.env("XDG_MENU_PREFIX", "arch-")

optional_require(machine .. "environment")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "scrolling",
    },
    scrolling = {
        follow_min_visible = 0.0,
        explicit_column_widths = "0.35, 0.5, 0.65, 1.0",
    },
    binds = {
        scroll_event_delay = 0,
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            vibrancy = 0.1696,
            new_optimizations = true,
            ignore_opacity = true,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        middle_click_paste = false,
    },
    input = {
        kb_layout = "custom",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        repeat_rate = 40,
        repeat_delay = 200,
        follow_mouse = 1,
        sensitivity = -0.5,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

local animations = {
    { leaf = "global", enabled = true, speed = 10, bezier = "default" },
    { leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" },
    { leaf = "windows", enabled = true, speed = 4.79, spring = "easy" },
    { leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" },
    { leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" },
    { leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" },
    { leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" },
    { leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" },
    { leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" },
    { leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" },
    { leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" },
    { leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" },
    { leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" },
    { leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" },
    { leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" },
    { leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" },
}

for _, animation in ipairs(animations) do
    hl.animation(animation)
end

optional_require(machine .. "input")

local main_mod = "SUPER"

local function app_exec(command)
    return hl.dsp.exec_cmd("uwsm app -- sh -lc " .. shell_quote(command))
end

hl.bind(main_mod .. " + Return", app_exec(programs.terminal))
hl.bind(main_mod .. " + q", hl.dsp.window.close())
hl.bind(main_mod .. " + CTRL + q", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(main_mod .. " + N", app_exec(programs.file_manager))
hl.bind(main_mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + A", hl.dsp.exec_cmd("~/.config/hypr/toggle-opacity.sh"))
hl.bind(main_mod .. " + d", app_exec(programs.menu))
hl.bind(main_mod .. " + Period", app_exec("vicinae vicinae://launch/core/search-emojis"))
hl.bind(main_mod .. " + w", app_exec(programs.browser))
hl.bind(main_mod .. " + P", hl.dsp.window.pin())
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("Print", app_exec(programs.screenshot_save))
hl.bind("CTRL + Print", app_exec(programs.screenshot_copy))
hl.bind("SHIFT + Print", app_exec(programs.screenshot_copy_quick))
hl.bind("CTRL + SHIFT + Print", app_exec(programs.screenshot_edit))
hl.bind(main_mod .. " + v", app_exec("pavucontrol"))
hl.bind(main_mod .. " + CTRL + L", hl.dsp.exec_cmd("loginctl lock-session"))

local focus_binds = {
    h = "l",
    j = "d",
    k = "u",
    l = "r",
}

for key, direction in pairs(focus_binds) do
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

for workspace = 1, 10 do
    local key = workspace % 10

    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

for workspace = 11, 20 do
    local key = workspace % 10

    hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind("ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + comma", hl.dsp.layout("move +col"))
hl.bind(main_mod .. " + m", hl.dsp.layout("move -col"))
hl.bind(main_mod .. " + mouse_up", hl.dsp.layout("move +col"))
hl.bind(main_mod .. " + mouse_down", hl.dsp.layout("move -col"))
hl.bind(main_mod .. " + SHIFT + comma", hl.dsp.layout("swapcol r"))
hl.bind(main_mod .. " + SHIFT + m", hl.dsp.layout("swapcol l"))
hl.bind(main_mod .. " + u", hl.dsp.layout("colresize +conf"))
hl.bind(main_mod .. " + i", hl.dsp.layout("colresize -conf"))
hl.bind(main_mod .. " + SHIFT + u", hl.dsp.layout("promote"))

hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(main_mod .. " + space", hl.dsp.exec_cmd("pkill -USR2 -n handy"))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("CTRL + ALT + Delete", hl.dsp.global("caelestia:session"))
hl.bind("CTRL + SUPER + K", hl.dsp.global("caelestia:showall"))

hl.window_rule({
    name = "transparent-apps",
    match = { class = "^(Code|Slack|WebCord|Spotify|Alacritty|foot|footclient|com.mitchellh.ghostty)$" },
    opacity = "0.9 0.6",
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "xwayland-drag-fix",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

hl.window_rule({
    name = "chatterino",
    match = { class = "^(com.chatterino.chatterino)$", title = "negative:.*Usercard.*" },
    workspace = "19",
    tile = true,
})

hl.window_rule({
    name = "chatterino-floating-popup",
    match = { class = "^(com.chatterino.chatterino)$", float = true },
    float = true,
    move = { "cursor_x-20", "cursor_y-20" },
})

hl.window_rule({ name = "foot-code-terminal", match = { title = "^(foot: Code)$" }, workspace = "3" })
hl.window_rule({ name = "jellyfin-desktop", match = { class = "^(com.github.iwalton3.jellyfin-media-player)$" }, workspace = "9" })
hl.window_rule({ name = "jellyfin-player-tile", match = { class = "^(Jellyfin Media Player)$" }, workspace = "9", tile = true })
hl.window_rule({ name = "jellyfin-browser", match = { class = "^(Brave-browser)$", title = "^(Jellyfin)$" }, workspace = "9" })
hl.window_rule({ name = "cypress", match = { class = "^(Cypress)$" }, workspace = "9" })
hl.window_rule({
    name = "vesktop-scratchpad",
    match = { class = "^(vesktop)$" },
    workspace = "special:magic",
})
hl.window_rule({ name = "slack-scratchpad", match = { class = "^(Slack)$" }, workspace = "special:magic" })

local floating_classes = {
    yad = "^(Yad)$",
    galculator = "^(Galculator)$",
    blueberry = "^(Blueberry.py)$",
    pavucontrol = "^(pavucontrol)$",
    qt5ct = "^(qt5ct)$",
    qt6ct = "^(qt6ct)$",
    ["nwg-look"] = "^(nwg-look)$",
    ["bluetooth-sendto"] = "^(Bluetooth-sendto)$",
    pamac = "^(Pamac-manager)$",
    ["pavucontrol-pulseaudio"] = "^(org.pulseaudio.pavucontrol)$",
}

for name, class in pairs(floating_classes) do
    hl.window_rule({ name = name .. "-float", match = { class = class }, float = true })
end

hl.window_rule({ name = "notification-toasts-float", match = { title = "^(notificationtoasts_.*)$" }, float = true })
hl.window_rule({ name = "bitwarden-extension-float", match = { class = "^(Brave-browser)$", title = "^(_crx_nngceckbapebfimnlniiiahkandclblb)$" }, float = true })
hl.window_rule({ name = "microsoft-teams", match = { initial_title = "^(Microsoft Teams)$" }, workspace = "5", tile = true })
hl.window_rule({ name = "battlenet-updates-float", match = { class = "^(battle.net.exe)$", title = "^(Battle.net Updates)$" }, float = true })

hl.window_rule({
    name = "picture-in-picture",
    match = { title = "^(Picture( |-)in( |-)(p|P)icture)$" },
    float = true,
    pin = true,
    keep_aspect_ratio = true,
    no_initial_focus = true,
})

hl.window_rule({ name = "osu-fullscreen", match = { class = "^(osu!.exe)$" }, fullscreen = true, stay_focused = true })
hl.window_rule({ name = "steam-app-default-float", match = { initial_class = "^(steam_app_default)$" }, float = true })
hl.window_rule({ name = "steam-games-fullscreen", match = { initial_class = "^(steam_app_[0-9]+)$" }, fullscreen = true })
hl.window_rule({ name = "kwallet5-auth", match = { class = "^(kwalletd5)$" }, pin = true, center = true, workspace = "1", stay_focused = true })
hl.window_rule({ name = "kwallet6-auth", match = { class = "^(org.kde.kwalletd6)$" }, pin = true, workspace = "1", stay_focused = true })
hl.window_rule({ name = "1password-auth", match = { class = "^(1password)$", title = "^(1Password)$" }, pin = true, move = "cursor -50% -50%", stay_focused = true })
hl.window_rule({ name = "polkit-auth", match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true, pin = true, center = true, workspace = "1", stay_focused = true })
hl.window_rule({ name = "wine-installer-float", match = { initial_class = "^(msiexec.exe)$" }, float = true })
hl.window_rule({ name = "syncthingtray-float", match = { class = "^(syncthingtray)$" }, float = true, stay_focused = true })
hl.window_rule({ name = "dolphin-new-folder-dialog", match = { initial_title = "^(Create New Folder — Dolphin)$" }, stay_focused = true })
hl.window_rule({ name = "hyprland-polkit-agent", match = { title = "^(Hyprland Polkit Agent)$" }, stay_focused = true })

hl.window_rule({
    name = "xwayland-video-bridge-hide",
    match = { class = "^(xwaylandvideobridge)$" },
    opacity = "0.0 override",
    no_anim = true,
    no_initial_focus = true,
    max_size = { 1, 1 },
    no_blur = true,
})

hl.window_rule({
    name = "cua-agent-cursor-overlay",
    match = { title = "^(Cua\\.AgentCursorOverlay\\.default)$" },
    no_blur = true,
    no_shadow = true,
    border_size = 0,
    no_anim = true,
    no_initial_focus = true,
    no_focus = true,
})

hl.window_rule({ name = "dolphin-copy-dialog-float", match = { initial_title = "^(Copying — Dolphin)$" }, float = true })
hl.window_rule({ name = "xdg-portal-gtk", match = { class = "^(Xdg-desktop-portal-gtk)$" }, no_blur = true, center = true, border_size = 0, no_shadow = true })
hl.window_rule({ name = "satty-screenshot-editor", match = { class = "^(com.gabm.satty)$" }, float = true, center = true })
hl.window_rule({ name = "discord-popout", match = { initial_title = "^(Discord Popout).*$" }, float = true, pin = true })
hl.window_rule({ name = "google-meet-popout", match = { class = "^(brave-browser)$", initial_title = "^(Meet - .*)$" }, float = true, pin = true })

hl.window_rule({
    name = "screen-sharing-indicator",
    match = { title = "^(.*is sharing (your screen|a window).*)$" },
    no_anim = true,
    no_initial_focus = true,
    no_blur = true,
    border_size = 0,
    no_shadow = true,
    opacity = "1 override",
})

hl.window_rule({
    name = "scrcpy-phone-mirror",
    match = { class = "^(scrcpy)$" },
    float = true,
    keep_aspect_ratio = true,
})

hl.window_rule({ name = "wine-systray-move", match = { title = "^(Wine System Tray)$" }, move = { 500, 500 } })

hl.window_rule({
    name = "handy-recording-nofocus",
    match = { class = "^([Hh]andy)$", title = "^([Rr]ecording)$" },
    no_initial_focus = true,
    border_size = 0,
    no_shadow = true,
    no_blur = true,
    float = true,
})

hl.layer_rule({ name = "hyprpicker-no-anim", match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ name = "grimblast-selection-no-anim", match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ name = "swaync-control-center-blur", match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "layerrule-gtk-layer-shell", match = { namespace = "gtk-layer-shell" }, blur = true })
hl.layer_rule({ name = "layerrule-waybar", match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ name = "swaync-notification-blur", match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "logout-dialog-blur", match = { namespace = "logout_dialog" }, blur = true })
hl.layer_rule({
    name = "caelestia-picker-no-anim",
    match = { namespace = "^caelestia-(border-exclusion|area-picker)$" },
    no_anim = true,
})
hl.layer_rule({
    name = "caelestia-shell-fade",
    match = { namespace = "^caelestia-(drawers|background)$" },
    animation = "fade",
})

optional_require(machine .. "workspaces")
optional_require(machine .. "windowrules")
