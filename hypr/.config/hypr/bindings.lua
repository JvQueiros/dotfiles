-- Keep only your personal keybinding overrides here. Add new bindings with
-- o.bind or replace defaults with o.rebind.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding. o.rebind takes the same arguments as o.bind.
-- This example replaces the default file manager with Flea.
-- o.rebind("SUPER + SHIFT + F", "File manager", { launch = "flea" })

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + H", nil, "voxtype record toggle")
--unbind

hl.unbind("SUPER + RETURN")
hl.unbind("SUPER + ALT + RETURN")
hl.unbind("SUPER + SHIFT + RETURN")
hl.unbind("SUPER + SHIFT + F")
hl.unbind("SUPER + ALT + SHIFT + F")
hl.unbind("SUPER + SHIFT + B")
hl.unbind("SUPER + SHIFT + ALT + B")
hl.unbind("SUPER + SHIFT + M")
hl.unbind("SUPER + SHIFT + ALT + M")
hl.unbind("SUPER + SHIFT + N")
hl.unbind("SUPER + SHIFT + D")
hl.unbind("SUPER + SHIFT + O")
hl.unbind("SUPER + SHIFT + T")
hl.unbind("SUPER + SHIFT + SLASH")
hl.unbind("SUPER + CTRL + K")
hl.unbind("SUPER + SHIFT + S")

-- Web app unbinds.
hl.unbind("SUPER + SHIFT + G")
hl.unbind("SUPER + SHIFT + ALT + A")
hl.unbind("SUPER + SHIFT + C")
hl.unbind("SUPER + SHIFT + E")
hl.unbind("SUPER + SHIFT + Y")
hl.unbind("SUPER + SHIFT + W")
hl.unbind("SUPER + SHIFT + P")
hl.unbind("SUPER + SHIFT + X")
hl.unbind("SUPER + SHIFT + ALT + X")

-- Extra unbinds.
hl.unbind("SUPER + SHIFT + Y")

--- Application bindings.
o.bind("SUPER + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + ALT + RETURN", "Tmux", { omarchy = "terminal-tmux" })
o.bind("SUPER + SHIFT + RETURN", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + SHIFT + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + M", "Music", { omarchy = "or-focus spotify" })
o.bind("SUPER + SHIFT + ALT + M", "Music TUI", { tui = "cliamp", focus = true })
o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })
o.bind("SUPER + SHIFT + D", "Docker", { tui = "lazydocker" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + SHIFT + T", "Typora", { launch = "typora --enable-wayland-ime" })
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "1password" })
o.bind("SUPER + CTRL + K", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + SHIFT + S", "ScreenshotGrim", { launch = 'grim -g "$(slurp)" - | wl-copy' })

-- Web app bindings.
o.bind("SUPER + SHIFT + G", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + ALT + A", "Grok", { webapp = "https://grok.com" })
o.bind("SUPER + SHIFT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })
o.bind("SUPER + SHIFT + E", "Email", { webapp = "https://outlook.com" })
-- Replaced by Yazi below; both on one key would fire together.
-- o.bind("SUPER + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })
o.bind("SUPER + SHIFT + W", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
o.bind("SUPER + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })
o.bind("SUPER + SHIFT + X", "X", { webapp = "https://x.com/" })
o.bind("SUPER + SHIFT + ALT + X", "X Post", { webapp = "https://x.com/compose/post" })

-- Add extra bindings below.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")
o.bind("SUPER + SHIFT + Y", "Yazi", { tui = "yazi" })

-- Overwrite existing bindings with hl.unbind() first if needed.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu")


-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, { panel = "omarchy.emojis" })

-- Right Shift + ` ^ Ç } act as arrow keys on the ABNT2 layout. Hyprland has one
-- SHIFT modifier for both Shift keys, so these binds stay disabled unless Right
-- Shift is held; that way Left Shift still types the characters normally.
local right_shift_arrow_keys = {
  ["code:34"] = "Up",
  ["code:48"] = "Down",
  ["code:47"] = "Left",
  ["code:51"] = "Right",
}
local right_shift_arrows = {}

-- Each press is a complete down/up pair, so no key can be left stuck down.
-- `mods` is forwarded to the app (e.g. CTRL for Ctrl+arrow); "" sends a plain arrow.
local function tap_arrow(key, mods)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods or "", key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods or "", key = key, state = "up" }))
    end, { timeout = 10, type = "oneshot" })
  end
end

local function set_right_shift_arrows(enabled)
  for _, keybind in ipairs(right_shift_arrows) do
    keybind:set_enabled(enabled)
  end
end

-- Hyprland matches modifiers exactly, so each held-modifier combination needs its own bind.
local direction_of = { Up = "u", Down = "d", Left = "l", Right = "r" }
for code, arrow in pairs(right_shift_arrow_keys) do
  local function add(mods, action, suffix)
    table.insert(right_shift_arrows, hl.bind(mods .. " + " .. code, action, {
      repeating = true,
      description = "Arrow " .. arrow:lower() .. " (Right Shift" .. suffix .. ")",
    }))
  end
  table.insert(right_shift_arrows, hl.bind("SHIFT + " .. code, tap_arrow(arrow), {
    repeating = true,
    description = "Arrow " .. arrow:lower() .. " (Right Shift)",
  }))
  add("CTRL + SHIFT", tap_arrow(arrow, "CTRL"), " + Ctrl")
  add("ALT + SHIFT", tap_arrow(arrow, "ALT"), " + Alt")
  add("SUPER + SHIFT", hl.dsp.focus({ direction = direction_of[arrow] }), " + Super: focus")
end
set_right_shift_arrows(false)

-- Non-consuming, so Right Shift still capitalizes everything else as usual.
o.bind_hold("SHIFT + Shift_R", nil, function()
  set_right_shift_arrows(true)
end, nil, function()
  set_right_shift_arrows(false)
end, { ignore_mods = true, non_consuming = true })

-- Waybar replaces Omarchy's bar, so this toggles Waybar instead.
o.rebind("SUPER + SHIFT + SPACE", "Toggle top bar", "pkill -SIGUSR1 waybar")

-- Next monitor on ALT+SHIFT+TAB (was CTRL+ALT+TAB; replaces "previous window").
hl.unbind("CTRL + ALT + TAB")
o.rebind("ALT + SHIFT + TAB", "Focus on next monitor", hl.dsp.focus({ monitor = "+1" }))

-- Swap: ALT+TAB = next monitor, ALT+SHIFT+TAB = next window.
o.rebind("ALT + TAB", "Focus on next monitor", hl.dsp.focus({ monitor = "+1" }))
o.rebind("ALT + SHIFT + TAB", "Focus on next window", hl.dsp.window.cycle_next())
o.bind("ALT + SHIFT + TAB", "Reveal active window on top", hl.dsp.window.bring_to_top())
